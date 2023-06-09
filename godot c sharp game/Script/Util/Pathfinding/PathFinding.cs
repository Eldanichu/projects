using System;
using Godot;
using Godot.Collections;
using Array = Godot.Collections.Array;

namespace godotcsharpgame.Script.Util {
  public class PathFinding : TileMap {
    [Signal] public delegate void OnPlayerMoving(Vector2[] movePath);

    [Export] public Vector2 mapSize = new Vector2(15, 7);

    public TileMap TC { set; get; }

    private Vector2 _cellSize;
    private Array connections = new Array();
    private AStar2D _aStar;

    private Array ImmobilizedTileTypes = new Array() {
      {Global.TILE_TYPE.INVALID},
      {Global.TILE_TYPE.OB},
    };

    private Array ObjectTileTypes = new Array() {
      {Global.TILE_TYPE.BUILDING},
      {Global.TILE_TYPE.PLAYER},
      {Global.TILE_TYPE.MONSTER},
    };

    public override void _Ready() {
      TC = GetNode<TileMap>("%tc");
      _cellSize = CellSize * 0.5f;
      _aStar = new AStar2D();
      CalculateCells();
    }
    public void CalculateCells() {
      var obstacles = GetObstacles();
      var walkableCells = GenerateWalkableCells(obstacles);
      ConnectWalkableCells(walkableCells);
    }
    public Vector2 GetWorldCellVector2(Vector2 vector2) {
      return MapToWorld(vector2) + _cellSize;
    }

    public Vector2 MoveSnap(Vector2 position) {
      var mapPosition = WorldToMap(position);
      return MapToWorld(mapPosition) + _cellSize;
    }

    public Vector2[] GetMovePath(Vector2 mousePosition, Vector2 targetPosition) {
      var mouseMapPos = WorldToMap(mousePosition);
      var mouseCellId = GetPointIndex(mouseMapPos);

      var playerMapPos = WorldToMap(targetPosition);
      var playerCellId = GetPointIndex(playerMapPos);

      return _aStar.GetPointPath(playerCellId, mouseCellId);
    }

    public int GetNextCell(Vector2 position, Vector2 origin, Vector2 targetCell) {
      var dir = position.DirectionTo(targetCell);
      var local = WorldToMap(origin) + dir.Floor();
      var nextCellId = GetCellv(local);
      return nextCellId;
    }

    public bool IsValidCell(Vector2 position) {
      var mapPos = WorldToMap(position);
      var cellType = GetCellv(mapPos);
      L.t($"MouseClicked Cell Type->{cellType}");

      return !ImmobilizedTileTypes.Contains(cellType);
    }

    public bool CellHasObjectTC(Vector2 position) {
      var mapPos = TC.WorldToMap(position);
      var cellType = TC.GetCellv(mapPos);
      
      return ObjectTileTypes.Contains(cellType);
    }
    
    public bool CellHasObject(Vector2 position) {
      var mapPos = WorldToMap(position);
      var cellType = GetCellv(mapPos);
      
      return ImmobilizedTileTypes.Contains(cellType);
    }
    
    private Array GetObstacles() {
      var obTiles = new Array();
      foreach (Global.TILE_TYPE tileType in ImmobilizedTileTypes) {
        var _tiles = GetUsedCellsById((int)tileType);
        foreach (Vector2 tile in _tiles) {
          obTiles.Add(tile);
        }
      }

      foreach (var obTile in obTiles) {
        var tileVec = (Vector2)obTile;
        var index = GetPointIndex(tileVec);
        _aStar.AddPoint(index, tileVec);
      }

      return obTiles;
    }

    private Array GenerateWalkableCells(Array obstacles) {
      var globalCells = GetUsedCells();
      var cells = new Array();
      foreach (Vector2 point in globalCells) {
        if (obstacles.Contains(point)) {
          continue;
        }

        cells.Add(point);
        var cellIndex = GetPointIndex(point);
        _aStar.AddPoint(cellIndex, point);
      }

      return cells;
    }

    public int GetAroundCellsType(Vector2 point, TileMap map = null) {
      var _map = map;
      if (_map == null) {
        _map = this;
      }
      var pointsRels = new Array() {
        {point + Vector2.Left},
        {point + Vector2.Up},
        {point + Vector2.Right},
        {point + Vector2.Down}
      };
      int cellType = 4;
      int index = 0;
      var InvalidSide = new Array<bool>() {false, false, false, false};
      // check if point's 4 dirs of tile type is not -1;
      foreach (Vector2 pointsRel in pointsRels) {
        var _relCellType = _map.GetCellv(pointsRel);
        if (_relCellType == (int)Global.TILE_TYPE.INVALID) {
          InvalidSide[index] = true;
        }
        index++;
      }
      #region direction checking

      var l = InvalidSide[0];
      var u = InvalidSide[1];
      var r = InvalidSide[2];
      var b = InvalidSide[3];
      var lu = InvalidSide[0] && InvalidSide[1];
      var lb = InvalidSide[0] && InvalidSide[3];
      var ru = InvalidSide[2] && InvalidSide[1];
      var rb = InvalidSide[2] && InvalidSide[3];
      if (lb) {
        cellType = 6;
      }
      else if (lu) {
        cellType = 0;
      }
      else if (ru) {
        cellType = 2;
      }
      else if (rb) {
        cellType = 8;
      }
      else if (l) {
        cellType = 3;
      }
      else if (r) {
        cellType = 5;
      }
      else if (u) {
        cellType = 1;
      }
      else if (b) {
        cellType = 7;
      }

      #endregion


      return cellType;
    }

    public Array GetAroundCellsType(Vector2 point, int distance = 1) {
      var pointsRels = new Array();
      for (int i = 1; i < distance; i++) {
        pointsRels.Add((point + Vector2.Up * i) );
        pointsRels.Add((point + Vector2.Right * i) );
        pointsRels.Add((point + Vector2.Down * i) );
        pointsRels.Add((point + Vector2.Left * i) );
      }
      return pointsRels;
    }


    private void ConnectWalkableCells(Array points) {
      foreach (Vector2 point in points) {
        var pointIndex = GetPointIndex(point);
        var pointsRels = new Array() {
          {point + Vector2.Right},
          {point + Vector2.Left},
          {point + Vector2.Down},
          {point + Vector2.Up},
        };
        foreach (Vector2 pointRel in pointsRels) {
          var pointRelIndex = GetPointIndex(pointRel);
          if (IsOutSideMap(pointRel)) {
            continue;
          }

          if (!_aStar.HasPoint(pointRelIndex)) {
            continue;
          }

          _aStar.ConnectPoints(pointIndex, pointRelIndex, false);
          var line = new Array() {
            {_aStar.GetPointPosition(pointIndex)},
            {_aStar.GetPointPosition(pointRelIndex)}
          };
          connections.Add(line);
        }
      }
    }

    private bool IsOutSideMap(Vector2 point) {
      return point.x < 0 || point.y < 0 || point.x > mapSize.x || point.y > mapSize.y;
    }

    private int GetPointIndex(Vector2 point) {
      return (int)Math.Floor(point.x + mapSize.x * point.y);
    }
  }
}

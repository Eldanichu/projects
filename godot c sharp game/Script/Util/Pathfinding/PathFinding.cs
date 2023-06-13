using System;
using Godot;
using Godot.Collections;
using Array = Godot.Collections.Array;

namespace godotcsharpgame.Script.Util {
  public class PathFinding : TileMap {
    [Signal] public delegate void OnPlayerMoving(Vector2[] movePath);

    [Export] public Vector2 mapSize = new Vector2(15, 7);

    public Array WalkableCells;
    public Array ObstaclesCells;
    public Array PathConnections = new Array();
    public TileMap TC { set; get; }
    private Vector2 _cellSize;
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
      TC = TNode.GetNode<TileMap>(GetTree(), "%tc");
      _cellSize = CellSize * 0.5f;
      _aStar = new AStar2D();
      CalculateCells();
    }
    public void CalculateCells() {
      GetObstacles();
      GenerateWalkableCells();
      ConnectWalkableCells();
    }

    public Vector2[] GetMovePath(Vector2 startPosition, Vector2 targetPosition) {
      var mapStartPos = WorldToMap(startPosition);
      var startCellId = GetPointIndex(mapStartPos);

      var mapsTargetPos = WorldToMap(targetPosition);
      var targetCellId = GetPointIndex(mapsTargetPos);

      return _aStar.GetPointPath(targetCellId, startCellId);
    }
    public bool CellHasObjectTC(Vector2 position) {
      var cellType = GetCellType(TC, position);

      return ObjectTileTypes.Contains(cellType);
    }
    public bool CellHasObject(Vector2 position) {
      var cellType = GetCellType(this, position);

      return ImmobilizedTileTypes.Contains(cellType);
    }
    public int GetCellType(TileMap map, Vector2 position) {
      var mapPos = map.WorldToMap(position);
      var cellType = map.GetCellv(mapPos);
      return cellType;
    }
    public int GetAroundCellsType(Vector2 point) {
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
        var _relCellType = GetCellv(pointsRel);
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
    public Vector2 GetWorldCellVector2(Vector2 vector2) {
      return MapToWorld(vector2) + _cellSize;
    }
    public Vector2 GetPointMapPosition(Vector2 point) {
      return WorldToMap(point);
    }
    public Vector2 GetAttackDir(Vector2 point) {
      var mousePosition = GetGlobalMousePosition();
      var mouseDir = ToMapDirection(point, mousePosition).Floor();

      return mouseDir;
    }
    public Vector2 GetRandomWalkableDir(Vector2 point) {
      var pointsRels = new Array() {
        {point + Vector2.Left},
        {point + Vector2.Up},
        {point + Vector2.Right},
        {point + Vector2.Down}
      };

      var nextPoints = new Array();

      foreach (Vector2 pointsRel in pointsRels) {
        var relCellType = GetCellv(pointsRel);
        var objCellType = TC.GetCellv(pointsRel);
        if (ImmobilizedTileTypes.Contains(relCellType) || ObjectTileTypes.Contains(objCellType)) {
          continue;
        }
        nextPoints.Add(pointsRel);
      }

      var rnd = new Random();
      var index = rnd.R(0, nextPoints.Count - 1);
      var nextPoint = (Vector2)nextPoints[index];
      var nextDir = ToMapDirection(MapToWorld(point), MapToWorld(nextPoint)).Floor();

      return nextDir;
    }

    public Array GetRange(Vector2 point, Vector2 range) {
      var mapPoint = WorldToMap(point);

      var pointsRels = new Array() {
        {new Vector2(Mathf.Min(mapPoint.x, mapPoint.x - range.x), Mathf.Min(mapPoint.y, mapPoint.y - range.y))},
        {new Vector2(Mathf.Min(mapPoint.x, mapPoint.x + range.x), Mathf.Min(mapPoint.y, mapPoint.y - range.y))},
        {new Vector2(Mathf.Min(mapPoint.x, mapPoint.x - range.x), Mathf.Min(mapPoint.y, mapPoint.y + range.y))},
        {new Vector2(Mathf.Min(mapPoint.x, mapPoint.x + range.x), Mathf.Min(mapPoint.y, mapPoint.y + range.y))},
      };

      return pointsRels;
    }
    public float GetDistance(Vector2 start, Vector2 target) {
      var targetCellType = GetCellType(this, target);
      if (targetCellType == -1) {
        targetCellType = GetCellType(TC, target);
      }
      if (ImmobilizedTileTypes.Contains(targetCellType) && !ObjectTileTypes.Contains(targetCellType)) {
        return -1;
      }

      var mapStart = WorldToMap(start);
      var mapTarget = WorldToMap(target);

      return Mathf.Floor(mapStart.DistanceTo(mapTarget));
    }

    public Vector2 ToMapDirection(Vector2 point, Vector2 dirTo) {
      // 45 angles are 0.707, plus 0.3f to floor them to 1;
      var mapPoint = GetPointMapPosition(point);
      var mapDirTo = GetPointMapPosition(dirTo);
      var dir = mapPoint.DirectionTo(mapDirTo) + new Vector2(0.3f, 0.3f);
      return dir;
    }
    private void GetObstacles() {
      ObstaclesCells = new Array();
      foreach (Global.TILE_TYPE tileType in ImmobilizedTileTypes) {
        var _tiles = GetUsedCellsById((int)tileType);
        foreach (Vector2 tile in _tiles) {
          ObstaclesCells.Add(tile);
        }
      }

      foreach (var obTile in ObstaclesCells) {
        var tileVec = (Vector2)obTile;
        var index = GetPointIndex(tileVec);
        _aStar.AddPoint(index, tileVec);
      }
    }
    private void GenerateWalkableCells() {
      var globalCells = GetUsedCells();
      var cells = new Array();
      foreach (Vector2 point in globalCells) {
        if (ObstaclesCells.Contains(point)) {
          continue;
        }

        cells.Add(point);
        var cellIndex = GetPointIndex(point);
        _aStar.AddPoint(cellIndex, point);
      }
      WalkableCells = cells;
    }
    private void ConnectWalkableCells() {
      foreach (Vector2 point in WalkableCells) {
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
          PathConnections.Add(line);
        }
      }
    }
    private bool IsOutSideMap(Vector2 point) {
      var allCell = GetUsedCells();
      var startRange = (Vector2)allCell[0];
      var endRange = (Vector2)allCell[allCell.Count - 1];
      return point.x < startRange.x || point.y < startRange.y || point.x > endRange.x || point.y > endRange.y;
    }
    private int GetPointIndex(Vector2 point) {
      return (int)Math.Floor(point.x + mapSize.x * point.y);
    }
  }
}

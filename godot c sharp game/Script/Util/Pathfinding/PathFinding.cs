using System;
using Godot;
using Array = Godot.Collections.Array;

namespace godotcsharpgame.Script.Util {
  public class PathFinding : TileMap {
    [Signal] public delegate void OnPlayerMoving(Vector2[] movePath);
    
    [Export] public Vector2 mapSize = new Vector2(15, 7);

    public PlayerObject PlayerObject { set; get; }
    public KinematicBody2D PlayerNode;
    public Vector2 TargetPosition;
    public Vector2[] MovePath;
    public bool IsMoving;
    public int pathIndex;
    
    private Vector2 _cellSize;
    private Array connections = new Array();
    private AStar2D _aStar;
  

    public override void _Ready() {
      PlayerNode = TNode.GetNode<KinematicBody2D>(GetTree(), "%Player");
      _cellSize = CellSize * 0.5f;
      ResetPlayerPosition();
      _aStar = new AStar2D();
      var obstacles = GetObstacles();
      var walkableCells = GenerateWalkableCells(obstacles);
      ConnectWalkableCells(walkableCells);
    }

    public override void _Input(InputEvent @event) {
      if (PlayerObject == null) {
        return;
      }
      if (!(@event is InputEventMouseButton mb)) return;
      if (mb.ButtonIndex == 1 && mb.Pressed) {
        var mousePosition = GetGlobalMousePosition();

        if (IsValidCell(mousePosition)) {
          IsMoving = true;
          pathIndex = 0;
          TargetPosition = MoveSnap(mousePosition);
          GetMovePath(mousePosition, PlayerNode.Position);
        }
      }
    }

    public override void _PhysicsProcess(float delta) {
      if (PlayerObject == null) {
        return;
      }
      if (MovePath == null || MovePath.Length <= 0) {
        return;
      }

      if (pathIndex < MovePath.Length && IsMoving) {
        var point = MapToWorld(MovePath[pathIndex]) + _cellSize;
        var dist = Math.Floor(PlayerNode.Position.DistanceTo(point));
        // var dir = PlayerNode.Position.DirectionTo(point);
        if (dist <= 1d) {
          pathIndex++;
          L.t($"{pathIndex}");
        }

        PlayerNode.Position = PlayerNode.Position.LinearInterpolate(point, 0.18f);
      }
      else {
        pathIndex = 0;
        IsMoving = false;
        MovePath = new Vector2[0];
        emitMovement();
      }

      if (!IsMoving) {
        PlayerNode.Position = PlayerNode.Position.LinearInterpolate(TargetPosition, 0.3f);
      }
    }

    public Vector2 MoveSnap(Vector2 position) {
      var mapPosition = WorldToMap(position);
      return MapToWorld(mapPosition) + _cellSize;
    }

    public void GetMovePath(Vector2 mousePosition, Vector2 targetPosition) {
      var mouseMapPos = WorldToMap(mousePosition);
      var mouseCellId = GetPointIndex(mouseMapPos);

      var playerMapPos = WorldToMap(targetPosition);
      var playerCellId = GetPointIndex(playerMapPos);

      MovePath = _aStar.GetPointPath(playerCellId, mouseCellId);
      emitMovement();
    }

    public int GetNextCell(Vector2 origin, Vector2 targetCell) {
      var dir = PlayerNode.Position.DirectionTo(targetCell);
      var local = WorldToMap(origin) + dir.Floor();
      var nextCellId = GetCellv(local);
      return nextCellId;
    }

    public void emitMovement() {
      EmitSignal("OnPlayerMoving", MovePath);
    }
    private void ResetPlayerPosition() {
      var _playerPosition = PlayerNode.Position;
      PlayerNode.Position = MoveSnap(_playerPosition);
    }
    private Array GetObstacles() {
      var obTiles = GetUsedCellsById(9);
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

    private bool IsValidCell(Vector2 position) {
      var mapPos = WorldToMap(position);
      var cellType = GetCellv(mapPos);
      L.t($"MouseClicked Cell Type->{cellType}");
      return cellType != -1 && cellType != 9;
    }
  }
}

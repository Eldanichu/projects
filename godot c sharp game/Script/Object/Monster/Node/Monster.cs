using System;
using Godot;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Monster.Node {
  public class Monster : Godot.Node2D {

    private PathFinding _map;
    private Vector2[] MovePath;
    private Tween _tweenMove;
    private Tick moveTick;
    private Vector2 lastCell = Vector2.Zero;

    private Polygon2D ViewRange;
    private Vector2[] ViewRangeShape = new Vector2[4];
    private Vector2 viewRangeSize;

    [Export]
    public float moveInterval = 3f;

    public int TileIndex { set; get; }
    public Vector2 intersectPoint { get; set; }

    public override void _Ready() {
      SetupNode();
    }
    private void SetupNode() {
      _tweenMove = new Tween();
      AddChild(_tweenMove);
      moveTick = new Tick(0, moveInterval);
      AddChild(moveTick);
      _map = TNode.GetNode<PathFinding>(GetTree(), "%map");

      ViewRange = new Polygon2D() {
        Modulate = Color.Color8(255, 255, 255, 55)
      };
      AddChild(ViewRange);
      Reset();
      UpdateTileIndex();
      CreateViewRange(_map.CellSize, new Vector2(1, 1));
      moveTick.OnTick += RandMovement;
      moveTick.Start();
    }

    public void RandMovement(int tick) {
      var mapPosition = _map.WorldToMap(Position);
      var nextDir = _map.GetRandomWalkableDir(mapPosition);
      if (lastCell != Vector2.Zero) {
        // L.t($"{lastCell}");
        _map.TC.SetCellv(lastCell, (int)Global.TILE_TYPE.INVALID);
      }
      var cell = _map.WorldToMap(Position) + nextDir;
      var point = _map.GetWorldCellVector2(cell);
      _tweenMove.InterpolateProperty(this,
              "position",
              Position,
              point,
              0.1f,
              Tween.TransitionType.Cubic,
              Tween.EaseType.OutIn
      );
      _map.TC.SetCellv(cell, (int)Global.TILE_TYPE.MONSTER);
   
      lastCell = cell;
      _tweenMove.Start();
      moveTick.Start();
      UpdateTileIndex();
      UpdateViewRangePosition();
      // L.t($"move {tick} - path{_map.WorldToMap(Position) + nextDir}");
    }

    public void CreateViewRange(Vector2 cellSize, Vector2 range) {
      var cellArea = cellSize.x + cellSize.y;
      var size = cellArea * 0.25f;
      var origin = -size;
      // var rangePoly = _map.GetRange(Position, range);
      viewRangeSize = cellSize * (range * -1);
      //up left
      ViewRangeShape[0] = new Vector2(origin, origin);
      // up right
      ViewRangeShape[1] = new Vector2(cellArea * range.x + size, origin);
      // down right
      ViewRangeShape[2] = new Vector2(cellArea * range.x + size, cellArea * range.y + size);
      // down left
      ViewRangeShape[3] = new Vector2(origin, cellArea * range.y + size);
      ViewRange.Polygon = ViewRangeShape;
      UpdateViewRangePosition();
    }

    private void UpdateViewRangePosition() {
      var mousePosition = Position;
      var mapMousePosition = _map.WorldToMap(mousePosition);
      var halfCellSize = _map.CellSize * 0.5f;
      var cellSizedPosition = _map.MapToWorld(mapMousePosition) + halfCellSize;
      ViewRange.Position = cellSizedPosition - Position + viewRangeSize;
    }

    public override void _PhysicsProcess(float delta) {
      if (intersectPoint == -Vector2.One) {
        return;
      }
      var intersect = Geometry.IsPointInPolygon(new Vector2(0,0),ViewRangeShape);
      if (intersect) {
        return;
      }
      L.t($"{intersect}");
    }

    private void Reset() {
      lastCell = _map.WorldToMap(Position);
      _map.TC.SetCellv(lastCell, (int)Global.TILE_TYPE.MONSTER);
    }

    private void UpdateTileIndex() {
      var mapPosition = _map.WorldToMap(Position);
      TileIndex = _map.GetPointIndex(mapPosition);
    }
  }
}

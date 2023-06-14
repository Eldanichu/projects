using Godot;
using Godot.Collections;
using godotcsharpgame.Script.Object.Player.Node;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Monster.Node {
  public class Monster : Node2D {

    private PathFinding _map;
    private Vector2[] MovePath;
    private Tween _tweenMove;
    private Tick moveTick;
    private Vector2 lastCell = Vector2.Zero;

    private Polygon2D ViewRange;
    private Vector2[] ViewRangeShape = new Vector2[4];
    private Vector2[] ViewRangeShapePositionRelative = new Vector2[4];
    private Vector2 viewRangeSize;

    private PlayerNode _player;

    [Export] public float moveInterval = 3f;
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
      var _tc = TNode.GetNode<TileMap>(GetTree(), "tc");

      _player = _tc.GetNode<PlayerNode>("%Player");

      ViewRange = new Polygon2D() {
        Modulate = Color.Color8(255, 255, 255, 55)
      };
      AddChild(ViewRange);
      Reset();
      UpdateTileIndex();
      CreateViewRange(_map.CellSize, new Vector2(1, 1));
      // moveTick.OnTick += RandMovement;
      // moveTick.Start();
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

      // intersectPoint = _map.WorldToMap(PlayerNode.Position);
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

      for (int i = 0; i < ViewRangeShape.Length; i++) {
        ViewRangeShapePositionRelative[i] = Position - ViewRangeShape[i] + _map.CellSize;
      }

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
      _player.GetPlayerShape();

      var intersect = Geometry.IntersectPolygons2d(
              _player.PlayerShape,
              ViewRangeShapePositionRelative
      );
      if (intersect.Count <= 0) {
        return;
      }

      var poly = (Vector2[])intersect[0];
      var point = poly[0] - _map.CellSize;
      var playerPos = _map.WorldToMap(point);
      L.t($" - {playerPos} - tileType {_map.GetPositionObjectType(point)}");
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

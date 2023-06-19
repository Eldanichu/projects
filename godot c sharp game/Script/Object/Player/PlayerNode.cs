using System;
using Godot;
using godotcsharpgame.Script.Object.Damage;
using godotcsharpgame.Script.Object.Properties;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Player {
  public class PlayerNode : Node2D {
    private DamageObject _dmage;


    private PathFinding _map;
    private Tween _tweenMove;
    private Polygon2D AttackArea;
    private readonly Vector2[] AttackAreaShape = new Vector2[4];

    private Line2D dirLine;
    private ProgressBar expBar;
    private TextureProgress hpBar;
    private Label hpText;
    private Vector2 lastCell = Vector2.Zero;
    public int MoveIndex;
    public float moveInterval = 0.2f;
    private Vector2[] MovePath;
    private Tick moveTick;
    private TextureProgress mpBar;
    private Label mpText;

    public PlayerProperties props;

    public Vector2[] PlayerShape { set; get; }
    public PlayerObject PlayerObject { set; get; }

    public override void _Ready() {
      SetupNode();
      ResetPlayer();
      _PlayerEvent();
    }

    private void SetupNode() {
      _tweenMove = new Tween();
      AddChild(_tweenMove);
      moveTick = new Tick(0, moveInterval);
      AddChild(moveTick);
      moveTick.OnTick += MoveAlongPath;

      _map = TNode.GetNode<PathFinding>(GetTree(), "%map");
      dirLine = GetNode<Line2D>("%lineDir");

      AttackArea = new Polygon2D {
        Modulate = Color.Color8(255, 255, 255, 55)
      };
      AddChild(AttackArea);

      var g = GetTree().Root.GetNodeOrNull("main");
      hpText = g.FindNode("hp").GetNode<Label>("text");
      hpBar = g.FindNode("hp").GetNode<TextureProgress>("pg");
      mpText = g.FindNode("mp").GetNode<Label>("text");
      mpBar = g.FindNode("mp").GetNode<TextureProgress>("pg");
      expBar = g.FindNode("exp").GetNode<ProgressBar>("pg");
    }

    public override void _Process(float delta) {
      if (PlayerObject == null) return;

      UIUpdating();
    }

    public override void _Input(InputEvent @event) {
      // if (PlayerObject == null) {
      //   return;
      // }
      PlayerMouseMoveEvent(@event);
      PlayerClickEvent(@event);
    }

    public override void _PhysicsProcess(float delta) {
    }

    public override void _ExitTree() {
      base._ExitTree();
      QueueFree();
    }

    private void MoveAlongPath(int count) {
      if (MovePath == null || MovePath.Length <= 0) return;

      if (MoveIndex >= MovePath.Length) {
        moveTick.Stop();
        return;
      }

      var movePathLength = Math.Min(MoveIndex + 1, MovePath.Length - 1);
      var nextCell = MovePath[movePathLength];
      var nextPoint = _map.GetWorldCellVector2(nextCell);
      if (_map.CellHasObjectTC(nextPoint) || _map.CellHasObject(nextPoint)) return;

      if (lastCell != Vector2.Zero) _map.TC.SetCellv(lastCell, (int)Global.TILE_TYPE.INVALID);

      var cell = MovePath[MoveIndex];
      var point = _map.GetWorldCellVector2(cell);
      _tweenMove.InterpolateProperty(this,
              "position",
              Position,
              point,
              0.1f,
              Tween.TransitionType.Cubic,
              Tween.EaseType.OutIn
      );
      _map.TC.SetCellv(cell, (int)Global.TILE_TYPE.PLAYER);
      lastCell = cell;
      _tweenMove.Start();
      MoveIndex++;
    }

    private void DoDamage() {

    }

    private void _PlayerEvent() {
      if (PlayerObject == null) return;

      PlayerObject.AbilityChanged += (state, amount) => {
        switch (state) {
          case Global.PLAYER_ABILITY.LEVEL:
            L.t("Level Up!");
            break;
        }
      };
    }

    private void PlayerClickEvent(InputEvent @event) {
      if (!(@event is InputEventMouseButton mb)) return;
      if (mb.ButtonIndex != 1 || !mb.Pressed) return;
      var mousePosition = GetGlobalMousePosition();
      var dist = _map.GetDistance(Position, mousePosition);
      L.t($"{dist}");

      // CreateViewRange(_map.CellSize, new Vector2(1, 1));

      moveTick.Stop();
      MovePath = _map.GetMovePath(mousePosition, Position);
      MoveIndex = 0;
      moveTick.Start();
    }

    private void PlayerMouseMoveEvent(InputEvent @event) {
      if (!(@event is InputEventMouseMotion)) return;
      var mouseDir = _map.GetAttackDir(Position);
      var cellSizedDir = mouseDir * _map.CellSize;
      // if (_map.CellHasObject(Position + cellSizedDir)) {
      //   return;
      // }

      CreateAttackArea(_map.CellSize, cellSizedDir);
      dirLine.Rotation = mouseDir.Angle();
    }

    public void CreateAttackArea(Vector2 cellSize, Vector2 dir) {
      var cellArea = cellSize.x + cellSize.y;
      var size = cellArea * 0.25f;
      var origin = -size;
      AttackAreaShape[0] = new Vector2(origin, origin);
      AttackAreaShape[1] = new Vector2(size, origin);
      AttackAreaShape[2] = new Vector2(size, size);
      AttackAreaShape[3] = new Vector2(origin, size);
      AttackArea.Polygon = AttackAreaShape;
      AttackArea.Position = Position - (Position - dir);
    }

    public void GetPlayerShape() {
      var cellSize = _map.CellSize;
      var cellArea = cellSize.x + cellSize.y;
      var size = cellArea * 0.25f;
      var origin = -size;
      PlayerShape = new Vector2[4];
      PlayerShape[0] = Position - new Vector2(origin, origin);
      PlayerShape[1] = Position - new Vector2(size, origin);
      PlayerShape[2] = Position - new Vector2(size, size);
      PlayerShape[3] = Position - new Vector2(origin, size);
    }

    public override void _Draw() {
      if (PlayerShape == null) return;

      DrawColoredPolygon(PlayerShape, Colors.Red);
    }

    private void ResetPlayer() {
      lastCell = _map.WorldToMap(Position);
      _map.TC.SetCellv(lastCell, (int)Global.TILE_TYPE.PLAYER);
    }

    private void UIUpdating() {
      props = PlayerObject.props;
      hpText.Text = $"{props.Hp0}/{props.Hp1}";
      mpText.Text = $"{props.Mp0}/{props.Mp1}";

      hpBar.Value = props.Hp0 / props.Hp1 * 100;
      mpBar.Value = props.Mp0 / props.Mp1 * 100;
      expBar.Value = props.Exp0 / props.Exp1 * 100;
    }
  }
}


// var item = new Items() {
//   _uid = StringUtil.GetId(),
//   ID = "00346",
//   NAME = "红瓶(小)"
// };
// cc.Insert(item);

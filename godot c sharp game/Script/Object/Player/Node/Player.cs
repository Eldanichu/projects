using System;
using System.Collections.Generic;
using Godot;
using godotcsharpgame.Script.Object.Damage;
using godotcsharpgame.Script.Object.Player.Obj;
using godotcsharpgame.Script.Util;
using Array = Godot.Collections.Array;

public class Player : Node2D {
  private ProgressBar expBar;
  private TextureProgress hpBar;
  private Label hpText;
  private TextureProgress mpBar;
  private Label mpText;
  private DamageObject _dmage;

  private Line2D dirLine;
  private Polygon2D AttackArea;
  private Polygon2D ViewRange;

  private PathFinding _map;
  private Vector2[] MovePath;
  private Tween _tweenMove;
  private Tick moveTick;
  private Vector2 lastCell = Vector2.Zero;

  public int MoveIndex;
  public float moveInterval = 0.2f;

  public PlayerProperties props;
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

    AttackArea = new Polygon2D() {
      Modulate = Color.Color8(255, 255, 255, 55)
    };
    ViewRange = new Polygon2D() {
      Modulate = Color.Color8(255, 255, 255, 55)
    };

    AddChild(AttackArea);
    AddChild(ViewRange);

    var g = GetTree().Root.GetNodeOrNull("main");
    hpText = g.FindNode("hp").GetNode<Label>("text");
    hpBar = g.FindNode("hp").GetNode<TextureProgress>("pg");
    mpText = g.FindNode("mp").GetNode<Label>("text");
    mpBar = g.FindNode("mp").GetNode<TextureProgress>("pg");
    expBar = g.FindNode("exp").GetNode<ProgressBar>("pg");
  }

  public override void _Process(float delta) {
    if (PlayerObject == null) {
      return;
    }
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

  public void Create(Global.CLASS_TYPE classType) {
    switch (classType) {
      case Global.CLASS_TYPE.tao:
        PlayerObject = new PlayerGenerator<TaoClass>();
        break;
      case Global.CLASS_TYPE.warrior:
        PlayerObject = new PlayerGenerator<WarClass>();
        break;
      case Global.CLASS_TYPE.wizard:
        PlayerObject = new PlayerGenerator<WizClass>();
        break;
    }

    PlayerObject.node = this;
    PlayerObject.LevelUp();
    var props = PlayerObject.GetProps(Global.PROP_TYPE.ATTACK);
    L.t($"{props}");
  }

  private void MoveAlongPath(int count) {
    if (MovePath == null || MovePath.Length <= 0) {
      return;
    }

    if (MoveIndex >= MovePath.Length) {
      moveTick.Stop();
      return;
    }

    var movePathLength = Math.Min(MoveIndex + 1, MovePath.Length - 1);
    var nextCell = MovePath[movePathLength];
    var nextPoint = _map.GetWorldCellVector2(nextCell);
    if (_map.CellHasObjectTC(nextPoint) || _map.CellHasObject(nextPoint)) {
      return;
    }

    if (lastCell != Vector2.Zero) {
      _map.TC.SetCellv(lastCell, (int)Global.TILE_TYPE.INVALID);
    }

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
    _dmage = new DamageObject() {
      Props = PlayerObject.props,
      PlayerClass = PlayerObject.PlayerClass
    };
    _dmage.GetPower();
    L.t($"{_dmage.Power} - {_dmage.IsCritical}");
  }

  private void _PlayerEvent() {
    if (PlayerObject == null) {
      return;
    }

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
    var range = _map.GetRange(Position, new Vector2(2, 2));
    var poly = new Vector2[4];
    poly[0] = (Vector2)range[0];
    
    ViewRange.Polygon = poly;
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

    AttackArea.Polygon = CreateAttackArea(_map.CellSize);
    AttackArea.Position = Position - (Position - cellSizedDir);
    dirLine.Rotation = mouseDir.Angle();
  }

  public Vector2[] CreateAttackArea(Vector2 cellSize) {
    var area = new Vector2[4];
    var cellArea = (cellSize.x + cellSize.y) / 2;
    var size = cellArea * 0.5f;
    var origin = -size;

    area[0] = new Vector2(origin, origin);
    area[1] = new Vector2(size, origin);
    area[2] = new Vector2(size, size);
    area[3] = new Vector2(origin, size);

    return area;
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


// var item = new Items() {
//   _uid = StringUtil.GetId(),
//   ID = "00346",
//   NAME = "红瓶(小)"
// };
// cc.Insert(item);

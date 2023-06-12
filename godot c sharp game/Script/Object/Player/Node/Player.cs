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

  private Polygon2D AttackArea;

  private PathFinding _map;
  private Vector2[] MovePath;
  private Tween _tweenMove;
  private Vector2 lastCell = Vector2.Zero;

  public int MoveIndex;
  public float moveInterval = 0.2f;
  public float elapseTime;

  public PlayerProperties props;
  public PlayerObject PlayerObject { set; get; }

  public override void _Ready() {
    SetupNode();
    ResetPlayer();
    _PlayerEvent();
  }

  public override void _Process(float delta) {
    if (PlayerObject == null) {
      return;
    }
    UIUpdating();
  }
  public override void _Input(InputEvent @event) {
    if (PlayerObject == null) {
      return;
    }
    PlayerMouseMoveEvent(@event);
    PlayerClickEvent(@event);
  }
  public override void _PhysicsProcess(float delta) {
    if (PlayerObject == null) {
      return;
    }
    MoveAlongPath(delta);
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
  public void _onStepFinished() {

  }
  private void SetupNode() {
    _tweenMove = new Tween();
    _tweenMove.Connect("tween_all_completed", this, "_onStepFinished");
    AddChild(_tweenMove);
    _map = TNode.GetNode<PathFinding>(GetTree(), "%map");

    AttackArea = new Polygon2D();
    AddChild(AttackArea);

    var g = GetTree().Root.GetNodeOrNull("main");
    hpText = g.FindNode("hp").GetNode<Label>("text");
    hpBar = g.FindNode("hp").GetNode<TextureProgress>("pg");
    mpText = g.FindNode("mp").GetNode<Label>("text");
    mpBar = g.FindNode("mp").GetNode<TextureProgress>("pg");
    expBar = g.FindNode("exp").GetNode<ProgressBar>("pg");
  }
  private void MoveAlongPath(float delta) {
    if (MovePath == null || MovePath.Length <= 0) {
      return;
    }
    if (elapseTime < moveInterval) {
      elapseTime += delta;
      return;
    }
    if (MoveIndex >= MovePath.Length) {
      return;
    }
    var movePathLength = (MoveIndex + 1 >= MovePath.Length) ? MovePath.Length - 1 : MoveIndex + 1;
    var nextCell = MovePath[movePathLength];
    var nextPoint = _map.GetWorldCellVector2(nextCell);
    if (_map.CellHasObjectTC(nextPoint) || _map.CellHasObject(nextPoint)) {
      return;
    }

    // L.t($"start move");
    if (lastCell != Vector2.Zero) {
      // L.t($"{lastCell}");
      _map.TC.SetCellv(lastCell, (int)Global.TILE_TYPE.INVALID);
    }
    var cell = MovePath[MoveIndex];
    var point = _map.GetWorldCellVector2(cell);
    _tweenMove.InterpolateProperty(this,
            "position",
            Position,
            point,
            moveInterval,
            Tween.TransitionType.Cubic,
            Tween.EaseType.OutIn
    );
    _map.TC.SetCellv(cell, (int)Global.TILE_TYPE.PLAYER);
    lastCell = cell;
    _tweenMove.Start();
    elapseTime = 0;
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
    if (mb.ButtonIndex == 1 && mb.Pressed) {
      var mousePosition = GetGlobalMousePosition();
      MovePath = _map.GetMovePath(mousePosition, Position);
      elapseTime = moveInterval;
      MoveIndex = 0;
    }
  }

  private void PlayerMouseMoveEvent(InputEvent @event) {
    if (!(@event is InputEventMouseMotion)) return;
    var mousePosition = GetGlobalMousePosition();
    var dir = Position.DirectionTo(mousePosition - _map.CellSize * 0.5f).Floor();
    var area = _map.GetAttackCells(_map.WorldToMap(Position), dir);
    L.t($"{dir}");
    AttackArea.Polygon = CreateAttackArea(area);
    AttackArea.Position = Position - _map.MapToWorld((Vector2)area[1]) - new Vector2(32,32);
  }

  public Vector2[] CreateAttackArea(Array areaPoints) {
    var area = new Vector2[4];
    var left = (Vector2)areaPoints[0];
    // var center = (Vector2)areaPoints[1];
    var right = (Vector2)areaPoints[2];
    var size = 32;
    var origin = -32;
    //left
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

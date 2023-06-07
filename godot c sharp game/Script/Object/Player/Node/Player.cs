using Godot;
using godotcsharpgame.Script.Object.Damage;
using godotcsharpgame.Script.Object.Player.Obj;
using godotcsharpgame.Script.Util;

public class Player : KinematicBody2D {
  private ProgressBar expBar;
  private TextureProgress hpBar;
  private Label hpText;
  private TextureProgress mpBar;
  private Label mpText;
  private DamageObject _dmage;

  private TileMap _tileMap;
  private Vector2 _cellSize;
  // private AStar2D _aStar;
  public Vector2 TargetPosition;
  // public Vector2 velocity;
  
  public PlayerProperties props;
  public PlayerObject PlayerObject { set; get; }

  public override void _Ready() {
    _tileMap = TNode.GetNode<TileMap>(GetTree(),"%map");
    _cellSize = _tileMap.CellSize * 0.5f;
    // _aStar = new AStar2D();
    var tiles = _tileMap.GetUsedCells();
    var randomPosition = (int)new Random().I(tiles.Count);
    TargetPosition = _tileMap.MapToWorld((Vector2)tiles[randomPosition]) + _cellSize;
    // TargetPosition = Position;
    // Create();
    _OnReady();
    _PlayerEvent();
  }

  public override void _PhysicsProcess(float delta) {
    Position = Position.LinearInterpolate(TargetPosition,0.1f);
  }
  public override void _Process(float delta) {
    if (PlayerObject == null) return;

    props = PlayerObject.props;
    hpText.Text = $"{props.Hp0}/{props.Hp1}";
    mpText.Text = $"{props.Mp0}/{props.Mp1}";

    hpBar.Value = props.Hp0 / props.Hp1 * 100;
    mpBar.Value = props.Mp0 / props.Mp1 * 100;
    expBar.Value = props.Exp0 / props.Exp1 * 100;
  }

  public override void _Input(InputEvent @event) {
    // if (PlayerObject == null) {
    //   return;
    // }
    if (@event is InputEventMouseButton mb) {
      if (mb.ButtonIndex == 1 && mb.Pressed) {
        var _map_pos = _tileMap.WorldToMap(GetGlobalMousePosition());
        var _cell_type = _tileMap.GetCellv(_map_pos);
        if (_cell_type == -1) {
          return;
        }
       
        TargetPosition = _tileMap.MapToWorld(_map_pos) + _cellSize;
        var dir = Position.DirectionTo(TargetPosition).Floor();
        
        L.t($"{_cell_type} - {_map_pos} -> {Position.AngleToPoint(GetGlobalMousePosition())}");
        // Position = _tileMap.MapToWorld(_map_pos) + _cellSize;
        // _dmage = new DamageObject() {
        //   Props = PlayerObject.props,
        //   PlayerClass = PlayerObject.PlayerClass
        // };
        // _dmage.GetPower();
        // L.t($"{_dmage.Power} - {_dmage.IsCritical}");
      }
    }
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
  private void _OnReady() {
    var g = GetTree().Root.GetNodeOrNull("main");
    hpText = g.FindNode("hp").GetNode<Label>("text");
    hpBar = g.FindNode("hp").GetNode<TextureProgress>("pg");
    mpText = g.FindNode("mp").GetNode<Label>("text");
    mpBar = g.FindNode("mp").GetNode<TextureProgress>("pg");
    expBar = g.FindNode("exp").GetNode<ProgressBar>("pg");
  }
  private void _PlayerEvent() {
    // if (PlayerObject == null) {
    //   return;
    // }
    // PlayerObject.AbilityChanged += (state, amount) => {
    //   switch (state) {
    //     case Global.PLAYER_ABILITY.LEVEL:
    //       L.t("Level Up!");
    //       break;
    //   }
    // };
  }

}


// var item = new Items() {
//   _uid = StringUtil.GetId(),
//   ID = "00346",
//   NAME = "红瓶(小)"
// };
// cc.Insert(item);

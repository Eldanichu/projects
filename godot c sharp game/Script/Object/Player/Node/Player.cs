using Godot;
using godotcsharpgame.Script.Util;

public class Player : Node {
  private ProgressBar expBar;
  private TextureProgress hpBar;
  private Label hpText;
  private TextureProgress mpBar;
  private Label mpText;
  public PlayerProperties props;
  public PlayerObject PlayerObject { set; get; }

  public override void _Ready() {
    Create();
    _OnReady();
    _PlayerEvent();
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
  public override void _ExitTree() {
    base._ExitTree();
    QueueFree();
  }
  public void Create() {
    PlayerObject = new CreatePlayer<PlayerObject, WizClass>().Player;
    PlayerObject.node = this;
    PlayerObject.LevelUp();
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

}


// var item = new Items() {
//   _uid = StringUtil.GetId(),
//   ID = "00346",
//   NAME = "红瓶(小)"
// };
// cc.Insert(item);

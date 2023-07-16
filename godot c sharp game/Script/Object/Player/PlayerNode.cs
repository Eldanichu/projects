using Godot;
using Godot.Collections;
using godotcsharpgame.Scene;
using godotcsharpgame.Script.Object.Damage;
using godotcsharpgame.Script.Object.Properties;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Player {
  public class PlayerNode : Node2D {
    public PlayerProperties props;
    public PlayerObject PlayerObject { set; get; }

    private Equipment Equipment;
    private Inventory Inventory;
    private DamageObject _dmage;
    private TextureProgressTween expBar;
    private TextureProgress hpBar;
    private Label hpText;
    private TextureProgress mpBar;
    private Label mpText;
    public override void _Ready() {
      SetupNode();
      // _PlayerEvent();
    }
    
    private void SetupNode() {
      Equipment = GetNodeOrNull<Equipment>("%Equipment");
      Inventory = GetNodeOrNull<Inventory>("%Inventory");
      PlayerObject.Inventory = Inventory;
      PlayerObject.Equipment = Equipment;
      
      var hp = GetNode<VBoxContainer>("%hp");
      var mp = GetNode<VBoxContainer>("%mp");
      hpText = hp.GetNode<Label>("text");
      hpBar = hp.GetNode<TextureProgress>("pg");
      mpText = mp.GetNode<Label>("text");
      mpBar = mp.GetNode<TextureProgress>("pg");
      expBar = GetNode<TextureProgressTween>("%exp");
    }

    public void Create(Dictionary form) {
      var classType = (Global.CLASS_TYPE)form["ClassType"];
      PlayerObject = new PlayerObject(classType);
      props = PlayerObject.props;
      PlayerObject.PlayerClass.Calculate();
      PlayerObject.RestoreStat();
      // PlayerObject.GiveExp(920000);
    }

    public override void _Input(InputEvent @event) {
      if (PlayerObject == null) return;

      PlayerMouseMoveEvent(@event);
      PlayerClickEvent(@event);
    }

    public override void _PhysicsProcess(float delta) {
      if (PlayerObject == null) return;

      UpdateUI();
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

    }

    private void PlayerMouseMoveEvent(InputEvent @event) {
      if (!(@event is InputEventMouseMotion)) return;
    }

    private void UpdateUI() {
      hpText.Text = props.DisplayNumber(props.Hp0, props.Hp1);
      mpText.Text = props.DisplayNumber(props.Mp0, props.Mp1);

      hpBar.Value = props.Percentage(props.Hp0, props.Hp1);
      mpBar.Value = props.Percentage(props.Mp0, props.Mp1);
      expBar.Value0 = props.Exp0;
      expBar.Value1 = props.Exp1;
    }

    public override void _ExitTree() {
      base._ExitTree();
      QueueFree();
    }
  }
}


// var item = new Items() {
//   _uid = StringUtil.GetId(),
//   ID = "00346",
//   NAME = "红瓶(小)"
// };
// cc.Insert(item);

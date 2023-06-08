using System;
using System.Collections.Generic;
using Godot;
using godotcsharpgame.Script.Object.Damage;
using godotcsharpgame.Script.Object.Player.Obj;
using godotcsharpgame.Script.Util;
using Array = Godot.Collections.Array;

public class Player : KinematicBody2D {
  private ProgressBar expBar;
  private TextureProgress hpBar;
  private Label hpText;
  private TextureProgress mpBar;
  private Label mpText;
  private DamageObject _dmage;

  public PlayerProperties props;
  public PlayerObject PlayerObject { set; get; }

  public override void _Ready() {
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

  public override void _Input(InputEvent @event) {
    if (PlayerObject == null) {
      return;
    }

    if (!(@event is InputEventMouseButton mb)) return;
    if (mb.ButtonIndex == 1 && mb.Pressed) {
      // _dmage = new DamageObject() {
      //   Props = PlayerObject.props,
      //   PlayerClass = PlayerObject.PlayerClass
      // };
      // _dmage.GetPower();
      // L.t($"{_dmage.Power} - {_dmage.IsCritical}");
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

using System;
using Godot;
using System.Collections.Generic;
using godotcsharpgame.Database.Attribute;
using godotcsharpgame.Script.Util;

public class Player : Node {
  public PlayerObject PlayerObject { set; get; }
  public PlayerProperties props;

  private Label hpText;
  private TextureProgress hpBar;
  private Label mpText;
  private TextureProgress mpBar;
  private ProgressBar expBar;

  public override void _Ready() {
    PlayerObject = new CreatePlayer<PlayerObject, WarClass>().Player;
    PlayerObject.LevelUp();
    _OnReady();
  }

  public override void _Process(float delta) {
    if (PlayerObject == null) {
      return;
    }

    props = PlayerObject.props;
    hpText.Text = $"{props.hp0}/{props.hp1}";
    mpText.Text = $"{props.mp0}/{props.mp1}";
    hpBar.Value = props.hp0 / props.hp1 * 100;
    mpBar.Value = props.mp0 / props.mp1 * 100;
    expBar.Value = props.exp0 / props.exp1 * 100;
  }

  private void _OnReady() {
    var g = GetTree().Root.GetNodeOrNull("main");
    hpText = g.FindNode("hp").GetNode<Label>("text");
    hpBar = g.FindNode("hp").GetNode<TextureProgress>("pg");
    mpText = g.FindNode("mp").GetNode<Label>("text");
    mpBar = g.FindNode("mp").GetNode<TextureProgress>("pg");
    expBar = g.FindNode("exp").GetNode<ProgressBar>("pg");
  }

  public override void _ExitTree() {
    base._ExitTree();
    QueueFree();
  }
}


// var item = new Items() {
//   _uid = StringUtil.GetId(),
//   ID = "00346",
//   NAME = "红瓶(小)"
// };
// cc.Insert(item);

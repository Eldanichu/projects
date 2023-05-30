using System;
using Godot;
using Godot.Collections;
using godotcsharpgame.Script.Util;
using Array = Godot.Collections.Array;

public class Player : Node2D {
  public PlayerObject PlayerObject { set; get; }
  public override void _Ready() {
    var p = new PlayerObject() {
      PlayerNode = this
    };
    L.t(p.GetObject().ToString());
    // var item = new Items() {
    //   _uid = StringUtil.GetId(),
    //   ID = "00346",
    //   NAME = "红瓶(小)"
    // };
    // cc.Insert(item);

  }
}

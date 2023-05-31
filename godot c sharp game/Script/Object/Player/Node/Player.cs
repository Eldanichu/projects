using System;
using Godot;
using Godot.Collections;
using godotcsharpgame.Script.Util;
using Array = Godot.Collections.Array;

public class Player : Node {
  public PlayerObject PlayerObject { set; get; }

  public override void _Ready() {
    PlayerObject = new PlayerObject(this);
    var playerClass = new TaoClass<PlayerClass>(PlayerObject);
    PlayerObject.LevelUp();
    

    L.t($"player properties ->{PlayerObject.GetObject()}");

    var owner = new BaseObject() {
      Object = this
    };
    
    var buff = new HealingBuff() {
      TickTimes = 5,
      Owner = owner
    };
    
    buff.Add();
    // var item = new Items() {
    //   _uid = StringUtil.GetId(),
    //   ID = "00346",
    //   NAME = "红瓶(小)"
    // };
    // cc.Insert(item);

  }

  public override void _ExitTree() {
    base._ExitTree();
    QueueFree();
  }
}

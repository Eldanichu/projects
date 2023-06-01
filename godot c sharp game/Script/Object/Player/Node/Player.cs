using System;
using Godot;
using godotcsharpgame.Script.Util;

public class Player : Node {
  public PlayerObject PlayerObject { set; get; }

  public override void _Ready() {
    var owner = new BaseObject {
      Object = this
    };

    var buff = new HealingBuff {
      TickTimes = 5,
      Owner = owner
    };

    buff.Add();

    var player = new CreatePlayer<PlayerObject,WarClass>().Player;
    player.StateChanged += (sender, value) => {
      L.t($"{sender} - {value}");
    };
    player.Attack(new Damage());
    
    
    L.t($"{Math.Floor(1.4)}");
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

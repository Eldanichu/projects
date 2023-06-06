using Godot;
using System;
using Godot.Collections;
using godotcsharpgame.Script.Util;

public class GUI : CanvasLayer {

  public override void _Ready() {
    var _OnCreatePlayer = new GlobalGameEvent() {
      Tree = GetTree(),
      EventName = "OnCreatePlayer"
    };
    _OnCreatePlayer.Connect(this, "_OnCreatePlayer");
  }

  public void _OnCreatePlayer(Dictionary<string, string> form) {
    L.t($"{form}");
    var main = GetTree().Root.GetNode<Node>("main");
    main.GetNode<CanvasLayer>("%Menu").Visible = false;
    Visible = true;
  }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}

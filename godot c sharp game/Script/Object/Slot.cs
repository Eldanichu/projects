using Godot;
using System;
using Godot.Collections;
using godotcsharpgame.Script.Util;
using Object = Godot.Object;

public class Slot : TextureButton {
  public string SlotName;
  
  public override void _Ready() {
    GetAttack();
    foo();
  }

  public void foo() {
    var Event = new GlobalGameEvent() {
      Tree = GetTree(),
      EventName = "PlayerAttack"
    };
    SlotName = "hi";
    L.t($"{SlotName}");
    Event.Emit(this);
  }

  public void GetAttack() {
    var Event = new GlobalGameEvent() {
      Tree = GetTree(),
      EventName = "PlayerAttack"
    };
    
    Event.Connect(this, "OnAttack");
  }

  public void OnAttack(Slot e) {
    e.SlotName = "fff";
    L.t($"{e.SlotName}");
  }
}
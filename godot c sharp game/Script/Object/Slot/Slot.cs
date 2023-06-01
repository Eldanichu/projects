using Godot;
using godotcsharpgame.Script.Util;

public class Slot : TextureButton {
  public string SlotName;

  public override void _Ready() {
    GetAttack();
    foo();
  }

  public void foo() {
    var Event = new GlobalGameEvent {
      Tree = GetTree(),
      EventName = "PlayerAttack"
    };
    SlotName = "hi";
    L.t($"{SlotName}");
    Event.Emit(this);
  }

  public void GetAttack() {
    var Event = new GlobalGameEvent {
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

using Godot;
using System;
using System.Reflection;
using SQLite;

public class Main : Node {
  public SceneTree tree;
  
  public override void _Ready() {
    var label = new Label {
      Text = "hello world",
      RectPosition = new Vector2(300, 300)
    };
    AddChild(label);
    // yield
    // await ToSignal(GetTree(), "idle_frame");
    // var b1 = new BigNumber("1502.5");
    // GD.Print(b1.ToAA());
    Attack();
  }
  
  public string Attack() {
    var damage = "12";
    return damage;
  }

  // public override void _Input(InputEvent @event) {
  //   if (@event is InputEventMouseMotion motion) {
  //     GD.Print($"[EVENT]{motion.Position}");
  //   }
  // }
}

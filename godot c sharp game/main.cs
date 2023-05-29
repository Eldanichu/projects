using Godot;
using System;

public class main : Node {
  public override async void _Ready() {
	var label = new Label {
	  Text = "hello world",
	  RectPosition = new Vector2(300, 300)
	};
	// yield
	await ToSignal(GetTree(), "idle_frame");

	AddChild(label);
	var Event = GetTree().Root.GetNode("main").GetNode("Event");

	// var b1 = new BigNumber("1502.5");
	// GD.Print(b1.ToAA());
  }

  // public override void _Input(InputEvent @event) {
  //   if (@event is InputEventMouseMotion motion) {
  //     GD.Print($"[EVENT]{motion.Position}");
  //   }
  // }
}

using Godot;
using System;
using System.Reflection;
using Godot.Collections;
using SQLite;

public class Main : Node {
  public SQLiteConnection connection = new DBConnection<Main>().connection;

  [Connect("Eldanado")]
  public override void _Ready() {

	
	// yield
	// await ToSignal(GetTree(), "idle_frame");
	// var b1 = new BigNumber("1502.5");
	// GD.Print(b1.ToAA());

  }

  // public override void _Input(InputEvent @event) {
  //   if (@event is InputEventMouseMotion motion) {
  //     GD.Print($"[EVENT]{motion.Position}");
  //   }
  // }
}

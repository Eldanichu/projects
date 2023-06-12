using Godot;
using SQLite;

public class Main : Node {
  public readonly SQLiteConnection Connection = new DBConnection<Main>().connection;

  private CanvasLayer _gui;
  private CanvasLayer _menu;
  
  [Connect("Eldanado")]
  public override void _Ready() {
	  _gui = GetNode<CanvasLayer>("%GUI");
	  _menu = GetNode<CanvasLayer>("%Menu");
	  // _gui.Visible = false;
	  // _menu.Visible = true;
	  // var tick = new Tick(5) {
	  //   Name = "test tick"
	  // };
	  //
	  // tick.OnTick += count => {
	  //   L.t($"ticks {count}");
	  //   if (count >= 2) tick.Pause();
	  // };
	  // AddChild(tick);
	  // tick.Start();

	  // var r = new Random();
	  // for (int i = 0; i < 15; i++) {
	  //   L.t($"{r.R(1,15)}");
	  // }

	  // yield
	  // await ToSignal(GetTree(), "idle_frame");
	  // var b1 = new BigNumber("1502.5");
	  // GD.Print(b1.ToAA());

  }
	
}

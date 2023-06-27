using Godot;
using godotcsharpgame.Script.Object.PlayerClass;
using godotcsharpgame.Script.Object.Properties;
using godotcsharpgame.Script.Util;
using SQLite;

namespace godotcsharpgame {
	public class Main : Node {
		public readonly SQLiteConnection Connection = new DBConnection<Main>().connection;

		private CanvasLayer _gui;
		private CanvasLayer _menu;
		private CanvasLayer TEST;
  
		[Connect("Eldanado")]
		public override void _Ready() {
			_gui = GetNode<CanvasLayer>("%GUI");
			_menu = GetNode<CanvasLayer>("%Menu");
			TEST = GetNode<CanvasLayer>("%TEST");
			var da = new TaoClass() {
				props = new PlayerProperties()
			};
			da.Calculate();
			L.t($"{da}");
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

		public override void _Input(InputEvent @event) {
			if (Input.IsActionJustReleased("ui_console")) {
				L.t($"toggle console");
				TEST.Visible = !TEST.Visible;
			}
		}
	}
}

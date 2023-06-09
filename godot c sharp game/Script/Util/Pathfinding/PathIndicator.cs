using Godot;

namespace godotcsharpgame.Script.Util {
  public class PathIndicator : Control {
	private Vector2[] MovePath;
	private TileMap _tileMap;

	public override void _Ready() {
	  _tileMap = GetNode<TileMap>("%map");
	  _tileMap.Connect("OnPlayerMoving", this, "OnPlayerMoving");
	}

	public void OnPlayerMoving(Vector2[] movePath) {
	  L.t("draw path");
	  MovePath = movePath;
	  Update();
	}

	public override void _Draw() {
	  L.t("draw");
	  if (MovePath == null || MovePath.Length <= 0) {
		return;
	  }

	  var movePath = new Vector2[MovePath.Length];
	  var index = 0;
	  foreach (Vector2 vector2 in MovePath) {
		movePath[index++] = GetWorldVector(vector2);
	  }

	  DrawPolyline(movePath, Color.Color8(255, 255, 255), 13f);
	  var startPoint = movePath[0];
	  var endPoint = movePath[movePath.Length - 1];
	  DrawCircle(startPoint, 15f, Colors.Orange);
	  DrawCircle(endPoint, 15f, Colors.Limegreen);
	}

	public Vector2 GetWorldVector(Vector2 v) {
	  return _tileMap.MapToWorld(v) + _tileMap.CellSize * 0.5f;
	}
  }
}

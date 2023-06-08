using Godot;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Scene {
  public class DrawPath : Control {
    private Vector2[] MovePath;
    private TileMap _tileMap;

    public override void _Ready() {
      _tileMap = TNode.GetNode<TileMap>(GetTree(), "%map");
      var _event = new GlobalGameEvent() {
        Tree = GetTree(),
        EventName = "OnPlayerMoving"
      };
      _event.Connect(this, "OnPlayerMoving");

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
        movePath[index++] = _tileMap.MapToWorld(vector2) + _tileMap.CellSize * 0.5f;
      }
      DrawPolyline(movePath, Color.Color8(255, 255, 255));
    }
  }
}

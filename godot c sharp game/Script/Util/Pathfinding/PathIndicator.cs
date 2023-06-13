using Godot;

namespace godotcsharpgame.Script.Util {
  public class PathIndicator : Control {
    private Vector2[] MovePath;
    private PathFinding _tileMap;
    

    public override void _Ready() {
      _tileMap = GetNode<PathFinding>("%map");
      _tileMap.Connect("OnPlayerMoving", this, "OnPlayerMoving");
    }

    public void OnPlayerMoving(Vector2[] movePath) {
      L.t("draw path");
      MovePath = movePath;
      Update();
    }

    public override void _Draw() {
      var cells = _tileMap.WalkableCells;
      if (cells == null) return;
      foreach (Vector2 vec in cells) {
        DrawString(GetFont("default"),_tileMap.MapToWorld(vec) + _tileMap.CellSize * 0.5f,$"{vec}",Colors.Aqua);
      }
    }

    public Vector2 GetWorldVector(Vector2 v) {
      return _tileMap.MapToWorld(v) + _tileMap.CellSize * 0.5f;
    }
  }
}

using Godot;

namespace godotcsharpgame.Script.Interface {
  public interface IMapObject {
    string uid { set; get; }
    int tileIndex { get; set; }
    Node NodeObject { get; set; }
  }
}

using Godot;
using godotcsharpgame.Script.Interface;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object {
  public class MapObject : IMapObject {
    private string _uid;
    public string uid {
      get => uid = StringUtil.GetId();
      set {
        uid = value;
      } 
    }
    public int tileIndex { get; set; }
    public Node NodeObject { get; set; }
  }
}

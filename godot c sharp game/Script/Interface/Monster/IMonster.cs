using Godot;
using godotcsharpgame.Script.Object.Monster.Base.Obj;

namespace godotcsharpgame.Script.Interface.Monster {
  public interface IMonster {
    Node Node { set; get; }
    string _uid { set; get; }
    string ID { set; get; }
    MonsterProps Props { set; get; }
  }
}

using godotcsharpgame.Script.Interface.Monster;
using godotcsharpgame.Script.Object.Monster.Base.Obj.State.Event.Action;

namespace godotcsharpgame.Script.Object.Monster.Base.Obj {
  public class MonsterObject : MonsterAction ,IMonster {

    public Godot.Node Node { get; set; }
    public string _uid { get; set; }
    public string ID { get; set; }
    public MonsterProps Props { get; set; }
  }
}

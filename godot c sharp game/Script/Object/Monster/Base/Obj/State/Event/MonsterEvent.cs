using godotcsharpgame.Script.Interface.Monster;
using godotcsharpgame.Script.Object.Damage;

namespace godotcsharpgame.Script.Object.Monster.Base.Obj.State.Event {
  public abstract class MonsterEvent : MonsterState,IMonsterEvent {

    public virtual DamageObject OnDamage(Godot.Object source, DamageObject damage) {
      throw new System.NotImplementedException();
    }
  }
}

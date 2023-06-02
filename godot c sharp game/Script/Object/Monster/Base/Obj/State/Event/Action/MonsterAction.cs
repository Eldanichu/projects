using godotcsharpgame.Script.Interface.Monster;
using godotcsharpgame.Script.Object.Damage;

namespace godotcsharpgame.Script.Object.Monster.Base.Obj.State.Event.Action {
  public abstract class MonsterAction : MonsterEvent,IMonsterAction {

    public virtual DamageType Attack(PlayerObject player, DamageObject damage) {
      throw new System.NotImplementedException();
    }
  }
}

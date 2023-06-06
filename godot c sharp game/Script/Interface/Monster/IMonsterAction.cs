using godotcsharpgame.Script.Object.Damage;

namespace godotcsharpgame.Script.Interface.Monster {
  public interface IMonsterAction {
    void Attack(BaseObject target, DamageObject damage);
    
  }
}

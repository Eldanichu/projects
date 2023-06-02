using godotcsharpgame.Script.Object.Damage;

namespace godotcsharpgame.Script.Interface.Monster {
  public interface IMonsterAction {
    DamageType Attack(PlayerObject player, DamageObject damage);

  }
}

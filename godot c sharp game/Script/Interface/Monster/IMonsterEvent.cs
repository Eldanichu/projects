using godotcsharpgame.Script.Object.Damage;

namespace godotcsharpgame.Script.Interface.Monster {
  public interface IMonsterEvent {
    DamageObject OnDamage(Godot.Object source,DamageObject damage);
  }
}

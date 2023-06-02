using godotcsharpgame.Script.Object.Damage;

public interface IPlayerState {
  Global.PLAYER_STATE state { set; get; }
  int OnAttack();
  int OnCast();
  decimal OnDamage(DamageObject dmg);
  int OnUseItem();
  int OnShop();
}

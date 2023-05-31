public interface IPlayerState {
  PlayerState.PLAYER_STATE state { set; get; }
  int OnAttack();
  int OnCast();
  decimal OnDamage(Damage dmg);
  int OnUseItem();
  int OnShop();
}

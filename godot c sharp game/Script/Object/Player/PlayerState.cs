public abstract class PlayerState : IPlayerState {

  public delegate void PlayerStateChanged(PLAYER_STATE sender, object value);

  public enum PLAYER_STATE {
    ATTACK,
    CAST,
    DAMAGE,
    USEITEM,
    SHOP
  }

  public PLAYER_STATE state { get; set; }

  public int OnAttack() {
    state = PLAYER_STATE.ATTACK;
    OnStateChanged(state, null);

    return (int)state;
  }
  public int OnCast() {
    state = PLAYER_STATE.CAST;
    OnStateChanged(state, null);
    return (int)state;
  }
  public decimal OnDamage(Damage dmg) {
    state = PLAYER_STATE.DAMAGE;
    OnStateChanged(state, dmg);
    return (int)state;
  }
  public int OnUseItem() {
    state = PLAYER_STATE.USEITEM;
    OnStateChanged(state, null);
    return (int)state;
  }
  public int OnShop() {
    state = PLAYER_STATE.SHOP;
    OnStateChanged(state, null);
    return (int)state;
  }
  public event PlayerStateChanged StateChanged;

  public void OnStateChanged(PLAYER_STATE sender, object value) {
    StateChanged?.Invoke(sender, value);
  }
}

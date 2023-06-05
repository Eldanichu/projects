using godotcsharpgame.Script.Object.Damage;

public abstract class PlayerState : IPlayerState {

  public delegate void PlayerStateChanged(Global.PLAYER_STATE sender, object value);
  public Global.PLAYER_STATE state { get; set; }

  public int OnAttack() {
    state = Global.PLAYER_STATE.ATTACK;
    OnStateChanged(state, null);

    return (int)state;
  }
  public int OnCast() {
    state = Global.PLAYER_STATE.CAST;
    OnStateChanged(state, null);
    return (int)state;
  }
  public decimal OnDamage(DamageObject dmg) {
    state = Global.PLAYER_STATE.DAMAGE;
    OnStateChanged(state, dmg);
    return (int)state;
  }
  public int OnUseItem() {
    state = Global.PLAYER_STATE.USEITEM;
    OnStateChanged(state, null);
    return (int)state;
  }
  public int OnShop() {
    state = Global.PLAYER_STATE.SHOP;
    OnStateChanged(state, null);
    return (int)state;
  }
  public event PlayerStateChanged StateChanged;
  private void OnStateChanged(Global.PLAYER_STATE sender, object value) {
    StateChanged?.Invoke(sender, value);
  }
}

using godotcsharpgame.Script.Interface.Damage;

namespace godotcsharpgame.Script.Object.Damage {
  public abstract class DamageEvent : IDamageEvent {

    public virtual void OnAttach() {
      throw new System.NotImplementedException();
    }
    public virtual void OnFinished() {
      throw new System.NotImplementedException();
    }
  }
}

using System.Collections.Generic;

namespace godotcsharpgame.Script.Object.Player.Obj.Base.State.Event {
  public abstract class PlayerEvent : PlayerState,IPlayerEvent {

    public virtual void LevelUp() {
      throw new System.NotImplementedException();
    }
    public virtual void GainExp(int exps) {
      throw new System.NotImplementedException();
    }
    public virtual bool Dead() {
      throw new System.NotImplementedException();
    }
    public virtual void GainItems(List<Item> items) {
      throw new System.NotImplementedException();
    }
  }
}

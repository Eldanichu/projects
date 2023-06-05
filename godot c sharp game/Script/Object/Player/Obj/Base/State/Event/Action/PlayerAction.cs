namespace godotcsharpgame.Script.Object.Player.Obj.Base.State.Event.Action {
  public abstract class PlayerAction : PlayerEvent,IPlayerAction {

    public virtual void GiveItem(Item item) {
      throw new System.NotImplementedException();
    }
    public virtual int TakeItem(string ItemId) {
      throw new System.NotImplementedException();
    }
    public virtual void AddSkill(Skill skill) {
      throw new System.NotImplementedException();
    }
    public virtual bool DeleteSkill(string skillId) {
      throw new System.NotImplementedException();
    }
    public virtual void GiveExp(int value = 0) {
      throw new System.NotImplementedException();
    }
    public virtual void GiveHp(int value = 0) {
      throw new System.NotImplementedException();
    }
    public virtual void GiveMp(int value = 0) {
      throw new System.NotImplementedException();
    }
  }
}

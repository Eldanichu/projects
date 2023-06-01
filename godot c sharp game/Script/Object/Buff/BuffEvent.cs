public abstract class BuffEvent : BaseBuff, IBuffEvent {
  public enum BUFF_STATE {
    ADD,
    AFFECT,
    REMOVE,
    FINISH
  }

  public BUFF_STATE State { set; get; }

  public virtual void OnChange(BUFF_STATE state) {

  }

  public virtual void OnAdd() {
    State = BUFF_STATE.ADD;
    OnChange(State);
  }

  public void OnRemove() {
    State = BUFF_STATE.REMOVE;
    OnChange(State);
  }

  public virtual void OnAffect() {
    State = BUFF_STATE.AFFECT;
    OnChange(State);
  }

  public virtual void OnFinish() {
    State = BUFF_STATE.FINISH;
    OnChange(State);
  }
}

public abstract class BaseBuff : BuffObject, IBaseBuff {
  public Tick tick { get; set; }
  public int TickTimes { get; set; }
  public virtual BaseObject Owner { get; set; }
  public virtual void Add() {
  }

  public virtual void Remove() {
  }
}

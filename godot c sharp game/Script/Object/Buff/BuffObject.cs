public abstract class BuffObject : BaseObject, IBuff {

  public string BuffName { get; set; }
  public Tick tick { get; set; }
  public BaseObject Owner { get; set; }
  public virtual void Effect(int time) {
    
  }
}

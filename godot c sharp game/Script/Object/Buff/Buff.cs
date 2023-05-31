using Godot;

public class Buff : Node,IBuff {
  public Buff() {
  }
  
  public Buff HealBuff() {
    var buffTick = new Tick(7);
    buffTick.OnTick += (count) => {
      //TODO do something to target Object.
    };
    AddChild(buffTick);
    return this;
  }
}

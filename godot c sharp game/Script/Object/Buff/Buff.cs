using System;
using godotcsharpgame.Script.Util;

public abstract class Buff : BuffEvent {
  private BUFF_STATE State { set; get; }
  
  public override void Add() {
    tick = new Tick(TickTimes);
    OnAdd();
  }
  
  public override void OnChange(BUFF_STATE state) {
    
  }

  public override void OnAdd() {
    State = BUFF_STATE.ADD;
    tick.Name = BuffName;
    if (String.IsNullOrEmpty(BuffName)) {
      tick.Name = StringUtil.GetId();
    }
    Owner.Object.AddChild(tick);
    OnChange(State);
    OnAffect();
  }

  public override void Remove() {
    if (Owner.Object == null) {
      return;
    }
    tick.QueueFree();
  }
  
  public override void OnAffect() {
    State = BUFF_STATE.AFFECT;
    tick.OnTick += (count) => {
      Effect(count);
    };
    tick.Start();
    OnChange(State);
  }

  public override void OnFinish() {
    State = BUFF_STATE.FINISH;
    tick.Pause();
    OnChange(State);
  }
}

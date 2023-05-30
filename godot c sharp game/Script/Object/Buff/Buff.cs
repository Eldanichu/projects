using Godot;

public class Buff : Skill,IBuff {
  public Node buff { set; get; }
  
  public void HealBuff() {
    // timer = new Timer() {
    //   Autostart = false,
    //   ProcessMode = 0,
    //   WaitTime = 1
    // };
    // skill.AddChild(timer);
    // timer.Connect("timerout",this,"heal")
    // timer.Start();
  
  }

  public void BleedingBuff() {
    throw new System.NotImplementedException();
  }
}

using System;
using Godot;

public class BaseSkill : SkillEvent, IBaseSkill {

  public BaseSkill() {
    MpReq = 1;
  }

  public decimal Cooldown { get; set; }
  public Timer Timer { get; set; }
  public int MpReq { get; set; }
  public void Cast() {
    throw new NotImplementedException();
  }
}

using System.Collections.Generic;

public class WizClass : PlayerClass {
  public WizClass() {
    Type = Global.CLASS_TYPE.wizard;
    HpRatio = 14;
    MpRatio = 13;
    HpBase = 26;
    HpAcc = 1.8m;
    MpBase = 5;
    MpAcc = 8m;
    MpRate = 1;
    AtkAcc = 3.5m;
    AtkRate = 5;
  }
  public override List<Skill> Skills { get; set; }

  public void UseSkill() {

  }
}

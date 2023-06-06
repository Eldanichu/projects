using System.Collections.Generic;

public class TaoClass : PlayerClass {
  public TaoClass() {
    Type = Global.CLASS_TYPE.tao;
    HpRatio = 14;
    MpRatio = 13;
    HpBase = 16;
    HpAcc = 2.5m;
    MpBase = 5;
    MpAcc = 6.6m;
    MpRate = 1;
    AtkAcc = 0.5m;
    AtkRate = 3;
  }
  public override List<Skill> Skills { get; set; }
  
  public void UseSkill() {

  }
}

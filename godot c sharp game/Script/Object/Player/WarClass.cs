using System.Collections.Generic;

public class WarClass : PlayerClass {
  public WarClass() {
    Type = Global.CLASS_TYPE.warrior;
    HpRatio = 14;
    HpBase = 4;
    HpAcc = 30;
    MpBase = 3.5m;
    MpRatio = 13;
    MpAcc = 3.4m;
    MpRate = 1;
    AtkAcc = 2.5m;
    AtkRate = 6;
  }
  public override List<Skill> Skills { get; set; }
}

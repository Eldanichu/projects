using System.Collections.Generic;

public class WarClass : PlayerClass {
  
  public WarClass() {
    Type = Global.CLASS_TYPE.warrior;
  }
  public override List<Skill> Skills { get; set; }

  public void UseSkill() {

  }
}

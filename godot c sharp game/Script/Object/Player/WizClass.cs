using System.Collections.Generic;

public class WizClass : PlayerClass {
  
  public WizClass() {
    Type = Global.CLASS_TYPE.wizard;
  }
  public override List<Skill> Skills { get; set; }

  public void UseSkill() {

  }
}

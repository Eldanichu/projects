﻿using System.Collections.Generic;

public class TaoClass : PlayerClass {
  
  public TaoClass() {
    Type = Global.CLASS_TYPE.tao;
  }
  public override List<Skill> Skills { get; set; }

  public void UseSkill() {

  }
}
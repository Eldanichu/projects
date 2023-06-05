using System.Collections.Generic;
using godotcsharpgame.Script.Object.Damage;

public class PlayerClass : IPlayerClass {
  public decimal HpRatio { set; get; }
  public decimal HpBase { set; get; }
  public decimal HpAcc { set; get; }
  public decimal MpBase { set; get; }
  public decimal MpRatio { set; get; }
  public decimal MpAcc { set; get; }
  public decimal MpRate { set; get; }
  public decimal DefRate => 0.325m;
  public decimal DefAcc => 0.117m;
  public decimal AtkRate => 0.415m;
  public decimal AtkAcc => 0.126m;

  public PlayerClass() {
    Skills = new List<Skill>();
  }
  public Global.CLASS_TYPE Type { get; set; }
  public virtual List<Skill> Skills { set; get; }
  
  public virtual void UseSkill(Skill skill) {
    
  }
  public virtual bool CanCast() {
    return true;
  }

  public virtual void Attack(DamageObject damage) {
    
  }
}

using System.Collections.Generic;

public abstract class PlayerClass : PlayerState, IPlayerClass {

  public PlayerClass() {
    Skills = new List<Skill>();
  }
  public Global.CLASS_TYPE Type { get; set; }
  public virtual List<Skill> Skills { set; get; }

  public virtual void UseSkill(Skill skill) {
    OnCast();
  }
  public virtual bool CanCast() {
    return true;
  }

  public virtual void Attack(Damage damage) {
    OnAttack();
  }
}

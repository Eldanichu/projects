using System.Collections.Generic;

public abstract class PlayerClass : PlayerState, IPlayerClass {
  public virtual List<Skill> Skills { set; get; }

  public PlayerClass() {
    Skills = new List<Skill>();
  }

  public virtual void UseSkill() {
    OnCast();
  }
  
  public virtual void Attack(Damage damage) {
    OnAttack();
  }
}

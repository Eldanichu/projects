using System.Collections.Generic;

public abstract class PlayerClass : PlayerState, IPlayerClass {

  public PlayerClass() {
    Skills = new List<Skill>();
  }
  public virtual List<Skill> Skills { set; get; }

  public virtual void UseSkill() {
    OnCast();
  }

  public virtual void Attack(Damage damage) {
    OnAttack();
  }
}

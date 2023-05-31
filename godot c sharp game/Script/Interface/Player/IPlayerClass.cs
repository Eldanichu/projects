using System.Collections.Generic;

public interface IPlayerClass {
  List<Skill> Skills { set; get; }
  void UseSkill();
  void Attack(Damage damage);
}

using System.Collections.Generic;

public interface IPlayerClass {
  Global.CLASS_TYPE Type { set; get; }
  List<Skill> Skills { set; get; }
  void UseSkill(Skill skill);
  bool CanCast();
  void Attack(Damage damage);
}

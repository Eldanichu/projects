using System.Collections.Generic;
using godotcsharpgame.Script.Object.Damage;

public interface IPlayerClass {
  Global.CLASS_TYPE Type { set; get; }
  List<Skill> Skills { set; get; }
  void UseSkill(Skill skill);
  bool CanCast();
  void Attack(DamageObject damage);
}

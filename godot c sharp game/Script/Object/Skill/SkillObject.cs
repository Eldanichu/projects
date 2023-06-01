public abstract class SkillObject : BaseObject, ISkill {

  public BaseObject Owner { get; set; }
  public BaseObject Target { get; set; }
}

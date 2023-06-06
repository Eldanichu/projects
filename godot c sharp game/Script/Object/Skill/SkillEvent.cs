using godotcsharpgame.Script.Object.Monster.Base.Obj;

public class SkillEvent : SkillObject, ISkillEvent {
  public enum SKILL_STATE {
    CASTING = 0,
    COOLDOWN = 1,
    FINISH = 2
  }

  public SKILL_STATE SkillState { get; set; }
  public virtual Tick tick { get; set; }

  public virtual void OnCast() {
    SkillState = SKILL_STATE.CASTING;
  }

  public virtual void OnCooldown() {
    SkillState = SKILL_STATE.COOLDOWN;
  }

  public virtual void OnFinish() {
    SkillState = SKILL_STATE.FINISH;
  }
  public override bool IsTargetObject(PlayerObject target) {
    throw new System.NotImplementedException();
  }
  public override bool IsTargetObject(MonsterObject target) {
    throw new System.NotImplementedException();
  }
}

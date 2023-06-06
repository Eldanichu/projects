using godotcsharpgame.Script.Object.Monster.Base.Obj;
using godotcsharpgame.Script.Util;

public class HealingBuff : Buff {

  public override void OnAdd() {
    BuffName = GetType().Name;
    base.OnAdd();
  }

  public override void OnChange(BUFF_STATE state) {
    L.t($"[healing] - {state}");
  }

  public override void Effect(int time) {
    base.Effect(time);
    L.t($"effecting - {time}");
  }
  public override bool IsTargetObject(PlayerObject target) {
    throw new System.NotImplementedException();
  }
  public override bool IsTargetObject(MonsterObject target) {
    throw new System.NotImplementedException();
  }
}

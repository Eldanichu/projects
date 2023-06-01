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
}

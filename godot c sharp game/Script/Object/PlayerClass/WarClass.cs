namespace godotcsharpgame.Script.Object.PlayerClass {
  public class WarClass : PlayerClass {
    public WarClass() {
      HpRatio = 14;
      HpBase = 4;
      HpAcc = 30;
      MpBase = 3.5f;
      MpRatio = 13;
      MpAcc = 3.4f;
      MpRate = 1;
      AtkAcc = 0.2f;
      AtkRate = 2;
    }
    public override void Calculate() {
      base.Calculate();
      props.Dc0 = CalcValue(0.1f, AtkRate, AtkAcc);
      props.Dc1 = CalcValue(0.5f, AtkRate, AtkAcc, true);
    }
  }
}

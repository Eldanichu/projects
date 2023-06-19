namespace godotcsharpgame.Script.Object.PlayerClass {
  public class WarClass : PlayerClass {
    public WarClass() {
      HpRatio = 14;
      HpBase = 4;
      HpAcc = 30;
      MpBase = 3.5m;
      MpRatio = 13;
      MpAcc = 3.4m;
      MpRate = 1;
      AtkAcc = 2.5m;
      AtkRate = 6;
    }
    public void Calculate() {
      base.Calculate();
      props.Dc0 = CalcValue(1m, AtkRate, AtkAcc);
      props.Dc1 = CalcValue(3m, AtkRate, AtkAcc, true);
    }
  }
}

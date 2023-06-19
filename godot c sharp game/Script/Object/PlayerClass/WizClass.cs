namespace godotcsharpgame.Script.Object.PlayerClass {
  public class WizClass : PlayerClass {
    public WizClass() {
      HpRatio = 14;
      MpRatio = 13;
      HpBase = 26;
      HpAcc = 1.8m;
      MpBase = 5;
      MpAcc = 8m;
      MpRate = 1;
      AtkAcc = 3.5m;
      AtkRate = 5;
    }

    public void Calculate() {
      base.Calculate();
      props.Mc0 = CalcValue(1m, AtkRate, AtkAcc);
      props.Mc1 = CalcValue(3m, AtkRate, AtkAcc, true);
    }
  }
}

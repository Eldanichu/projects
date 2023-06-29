namespace godotcsharpgame.Script.Object.PlayerClass {
  public class WizClass : PlayerClass {
    public WizClass() {
      HpRatio = 14;
      MpRatio = 13;
      HpBase = 26;
      HpAcc = 1.8f;
      MpBase = 5;
      MpAcc = 8f;
      MpRate = 1;
      AtkAcc = 1.5f;
      AtkRate = 1;
    }

    public override void Calculate() {
      base.Calculate();
      props.Mc0 = CalcValue(0.1f, AtkRate, AtkAcc);
      props.Mc1 = CalcValue(0.7f, AtkRate, AtkAcc, true);
    }
  }
}

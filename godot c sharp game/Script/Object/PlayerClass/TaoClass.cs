namespace godotcsharpgame.Script.Object.PlayerClass {
  public class TaoClass : PlayerClass {
    public TaoClass() {
      HpRatio = 14;
      MpRatio = 13;
      HpBase = 16;
      HpAcc = 2.5f;
      MpBase = 5;
      MpAcc = 6.6f;
      MpRate = 1;
      AtkAcc = 1.5f;
      AtkRate = 1;
    }
  
    public override void Calculate() {
      base.Calculate();
      props.Sc0 = CalcValue(0.1f, AtkRate, AtkAcc);
      props.Sc1 = CalcValue(0.6f, AtkRate, AtkAcc, true);
    }
  }
}

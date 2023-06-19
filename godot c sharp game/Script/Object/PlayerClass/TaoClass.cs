namespace godotcsharpgame.Script.Object.PlayerClass {
  public class TaoClass : PlayerClass {
    public TaoClass() {
      HpRatio = 14;
      MpRatio = 13;
      HpBase = 16;
      HpAcc = 2.5m;
      MpBase = 5;
      MpAcc = 6.6m;
      MpRate = 1;
      AtkAcc = 0.5m;
      AtkRate = 3;
    }
  
    public void Calculate() {
      base.Calculate();
      props.Sc0 = CalcValue(1m, AtkRate, AtkAcc);
      props.Sc1 = CalcValue(3m, AtkRate, AtkAcc, true);
    }
  }
}

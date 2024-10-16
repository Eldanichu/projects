using System;
using godotcsharpgame.Script.Object.Properties;

namespace godotcsharpgame.Script.Object.PlayerClass {
  public abstract class PlayerClass {
    public decimal HpRatio { set; get; }
    public decimal HpBase { set; get; }
    public decimal HpAcc { set; get; }
    public decimal MpBase { set; get; }
    public decimal MpRatio { set; get; }
    public decimal MpAcc { set; get; }
    public decimal MpRate { set; get; }
    public decimal DefRate => 0.325m;
    public decimal DefAcc => 0.117m;
    public decimal AtkRate { set; get; }
    public decimal AtkAcc { set; get; }
    private double ExpConst => 14;
    private double ExpFactor => 1.1;

    public PlayerProperties props { set; get; }

    public void Calculate() {
      if (props == null) {
        return;
      }
      var _level = Math.Max(1, props.Level);
      props.Hp1 = (int)(HpRatio + (_level / (1 + HpBase) + HpAcc) * _level);
      props.Mp1 = (int)(MpRate + (_level / (1 + MpBase) + MpAcc) * MpRate * _level);
      props.Exp1 = (int)(_level * ExpConst * ExpFactor * (_level * 1.1));
      props.Ac0 = CalcValue(0.84m, DefRate, DefAcc);
      props.Ac1 = CalcValue(0.96m, DefRate, DefAcc, true);
      props.Mac0 = CalcValue(0.1m, DefRate, DefAcc);
      props.Mac1 = CalcValue(0.5m, DefRate, DefAcc);
    }

    protected int CalcValue(
            decimal c,
            decimal rate,
            decimal acc,
            bool boMax = false
    ) {
      var _lv = (decimal)props.Level;
      if (c != 0m) _lv *= c;
      var value = Math.Floor(_lv * rate + acc * rate + 1);
      if (boMax) value += _lv * acc;

      return (int)Math.Floor(value);
    }
  }
}

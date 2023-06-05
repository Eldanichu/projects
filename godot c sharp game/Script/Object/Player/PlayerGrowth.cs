using System;
using System.Collections.Generic;

public class PlayerGrowth {
  private double ExpConst => 14;
  private double ExpFactor => 1.1;

  public PlayerClass PlayerClass { set; get; }
  public PlayerProperties props { set; get; }

  public PlayerGrowth() {
  
  }

  public void Calculate() {
    props.Hp1 = (int)(PlayerClass.HpRatio + (props.Level / (1 + PlayerClass.HpBase) + PlayerClass.HpAcc) * props.Level);
    props.Mp1 = (int)(PlayerClass.MpRate + (props.Level / (1 + PlayerClass.MpBase) + PlayerClass.MpAcc) * PlayerClass.MpRate * props.Level);
    props.Exp1 = (int)(props.Level * ExpConst * ExpFactor * (props.Level * 1.1));
    props.Ac0 = CalcValue(0.84m, PlayerClass.DefRate, PlayerClass.DefAcc);
    props.Ac1 = CalcValue(0.96m, PlayerClass.DefRate, PlayerClass.DefAcc, true);
    props.Mac0 = CalcValue(0.1m, PlayerClass.DefRate, PlayerClass.DefAcc);
    props.Mac1 = CalcValue(0.5m, PlayerClass.DefRate, PlayerClass.DefAcc);
    props.Sc0 = CalcValue(0m, PlayerClass.AtkRate, PlayerClass.AtkAcc);
    props.Sc1 = CalcValue(0m, PlayerClass.AtkRate, PlayerClass.AtkAcc, true);
  }

  private int CalcValue(
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

using System;
using System.Collections.Generic;
using godotcsharpgame.Script.Object.Damage;

public class PlayerClass : IPlayerClass {
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
  public PlayerProperties props { set; get; }
  private double ExpFactor => 1.1;
  private int Level = 0;

  public PlayerClass() {
    Skills = new List<Skill>();
  }
  public Global.CLASS_TYPE Type { get; set; }
  public virtual List<Skill> Skills { set; get; }

  public virtual void UseSkill(Skill skill) {

  }
  public virtual bool CanCast() {
    return true;
  }

  public virtual void Attack(DamageObject damage) {

  }
  public virtual void Calculate() {
    props.Hp1 = (int)(HpRatio + (props.Level / (1 + HpBase) + HpAcc) * props.Level);
    props.Mp1 = (int)(MpRate +
                      (props.Level / (1 + MpBase) + MpAcc) * MpRate * props.Level);
    props.Exp1 = (int)(props.Level * ExpConst * ExpFactor * (props.Level * 1.1));
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
    var _lv = (decimal)Level;
    if (c != 0m) _lv *= c;
    var value = Math.Floor(_lv * rate + acc * rate + 1);
    if (boMax) value += _lv * acc;

    return (int)Math.Floor(value);
  }
}

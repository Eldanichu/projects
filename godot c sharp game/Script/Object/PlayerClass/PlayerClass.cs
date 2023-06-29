using System;
using Godot;
using godotcsharpgame.Script.Object.Properties;

namespace godotcsharpgame.Script.Object.PlayerClass {
  public abstract class PlayerClass {
    public float HpRatio { set; get; }
    public float HpBase { set; get; }
    public float HpAcc { set; get; }
    public float MpBase { set; get; }
    public float MpRatio { set; get; }
    public float MpAcc { set; get; }
    public float MpRate { set; get; }
    public float DefRate => 0.325f;
    public float DefAcc => 0.117f;
    public float AtkRate { set; get; }
    public float AtkAcc { set; get; }
    private float ExpConst => 14;
    private float ExpFactor => 1.1f;

    public PlayerProperties props { set; get; }

    public virtual void Calculate() {
      if (props == null) {
        return;
      }
      var _level = Math.Max(1, props.Level);
      props.Hp1 = (int)(HpRatio + (_level / (1 + HpBase) + HpAcc) * _level);
      props.Mp1 = (int)(MpRate + (_level / (1 + MpBase) + MpAcc) * MpRate * _level);
      props.Exp1 = (int)(_level * ExpConst * ExpFactor * (_level * 1.1));
      props.Ac0 = CalcValue(0.84f, DefRate, DefAcc);
      props.Ac1 = CalcValue(0.96f, DefRate, DefAcc, true);
      props.Mac0 = CalcValue(0.1f, DefRate, DefAcc);
      props.Mac1 = CalcValue(0.5f, DefRate, DefAcc);
    }

    protected int CalcValue(
            float c,
            float rate,
            float acc,
            bool boMax = false
    ) {
      var _lv = (float)props.Level;
      if (c != 0f) _lv *= c;
      var value = Mathf.Floor(_lv * rate + acc * rate + 1);
      if (boMax) value += _lv * acc;

      return (int)Math.Floor(value);
    }
  }
}

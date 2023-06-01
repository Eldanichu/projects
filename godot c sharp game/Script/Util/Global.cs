using System;

public static class Global {
  public enum CLASS_TYPE {
    warrior = 1,
    wizard = 2,
    tao = 3
  }

  public struct ClassGrowth {
    private decimal HpRatio;
    private decimal HpBase;
    private decimal HpAcc;
    private decimal HpRate;

    private decimal MpRatio;
    private decimal MpBase;
    private decimal MpAcc;
    private decimal MpRate;

    private decimal DefRate => 0.325m;
    private decimal DefAcc => 0.117m;

    private decimal AtkRate => 0.415m;
    private decimal AtkAcc => 0.126m;


    private double ExpConst => 14;
    private double ExpFactor => 1.1;

    public long level { set; get; }
    public long HP => (long)(HpRatio + (level / (1 + HpBase) + HpAcc) * level);
    public long MP => (long)(MpRate + (level / (1 + MpBase) + MpAcc) * MpRate * level);
    public long EXP => (long)(level * ExpConst * ExpFactor * (level * 1.1));

    public long Ac0 { set; get; }
    public long Ac1 { set; get; }
    public long Mac0 { set; get; }
    public long Mac1 { set; get; }
    public long Dc0 { set; get; }
    public long Dc1 { set; get; }
    public long Sc0 { set; get; }
    public long Sc1 { set; get; }
    public long Mc0 { set; get; }
    public long Mc1 { set; get; }

    public void apply(CLASS_TYPE type) {
      switch (type) {
        case CLASS_TYPE.tao:
          Tao();
          break;
        case CLASS_TYPE.warrior:
          Warrior();
          break;
        case CLASS_TYPE.wizard:
          Wizard();
          break;
      }
    }
    private long CalcValue(
            decimal c, 
            decimal rate, 
            decimal acc, 
            bool boMax = false
    ) {
      var _lv = (decimal)level;
      if (c != 0m) {
        _lv *= c;
      }
      var value = Math.Floor(_lv * rate + acc * rate + 1);
      if (boMax) {
        value += _lv * acc;
      }

      return (long)Math.Floor(value);
    }
    public void Tao() {
      HpRatio = 14;
      MpRatio = 13;
      HpBase = 6;
      HpAcc = 2.5m;
      MpBase = 5;
      MpAcc = 8;
      MpRate = 1;
      
      Ac0 = CalcValue(0.84m, DefRate, DefAcc);
      Ac1 = CalcValue(0.96m, DefRate, DefAcc, true);
      Mac0 = CalcValue(0.1m, DefRate, DefAcc);
      Mac1 = CalcValue(0.5m, DefRate, DefAcc);
      
      Sc0 = CalcValue(0m, AtkRate, AtkAcc);
      Sc1 = CalcValue(0m, AtkRate, AtkAcc, true);
    }

    public void Wizard() {
      HpRatio = 14;
      MpRatio = 13;
      HpBase = 16;
      HpAcc = 1.8m;
      MpBase = 5;
      MpAcc = 2.2m;
      MpRate = 1;
      
      Ac0 = CalcValue(0.618m, DefRate, DefAcc);
      Ac1 = CalcValue(0.966m, DefRate, DefAcc, true);
      Mac0 = CalcValue(0.4m, DefRate, DefAcc);
      Mac1 = CalcValue(0.5m, DefRate, DefAcc);
      
      Mc0 = CalcValue(0m, AtkRate, AtkAcc);
      Mc1 = CalcValue(0m, AtkRate, AtkAcc, true);
    }

    public void Warrior() {
      HpRatio = 14;
      MpRatio = 13;
      HpBase = 4;
      HpAcc = 20;
      MpBase = 3.5m;
      MpAcc = 1;
      MpRate = 1;
      
      Ac0 = CalcValue(0.99m, DefRate, DefAcc);
      Ac1 = CalcValue(0m, DefRate, DefAcc, true);
      Mac0 = CalcValue(0.5m, DefRate, DefAcc);
      Mac1 = CalcValue(0.5m, DefRate, DefAcc);
      
      Dc0 = CalcValue(0m, AtkRate + 0.5m, AtkAcc);
      Dc1 = CalcValue(0m, AtkRate + 1.5m, AtkAcc, true);
    }
  }
}

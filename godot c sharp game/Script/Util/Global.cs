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

    private double ExpConst => 14;
    private double ExpFactor => 1.1;

    public long level { set; get; }
    public long HP => (long)(HpRatio + (level / (1 + HpBase) + HpAcc) * level);
    public long MP => (long)(MpRate + (level / (1 + MpBase) + MpAcc) * MpRate * level);

    public long EXP => (long)(level * ExpConst * ExpFactor * (level * 1.1));
    public void apply(Global.CLASS_TYPE type) {
      switch (type) {
        case Global.CLASS_TYPE.tao:
          Tao();
          break;
        case Global.CLASS_TYPE.warrior:
          Warrior();
          break;
        case Global.CLASS_TYPE.wizard:
          Wizard();
          break;
      }
    }

    public void Tao() {
      HpRatio = 14;
      MpRatio = 13;
      HpBase = 6;
      HpAcc = 2.5m;
      MpBase = 5;
      MpAcc = 8;
      MpRate = 1;
    }

    public void Wizard() {
      HpRatio = 14;
      MpRatio = 13;
      HpBase = 16;
      HpAcc = 1.8m;
      MpBase = 5;
      MpAcc = 2.2m;
      MpRate = 1;
    }

    public void Warrior() {
      HpRatio = 14;
      MpRatio = 13;
      HpBase = 4;
      HpAcc = 20;
      MpBase = 3.5m;
      MpAcc = 1;
      MpRate = 1;
    }
  }
}

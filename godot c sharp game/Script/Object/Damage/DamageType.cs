using System;
using godotcsharpgame.Script.Interface.Damage;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Damage {
  public class DamageType : DamageEvent, IDamageType {
    public virtual int CriticalChance {
      get => Math.Min(CONSTS.MAX_CRITCHANCE, _criticalChance);
      set => _criticalChance = value;
    }

    public virtual int CriticalStrength {
      get => Math.Min(CONSTS.MAX_STRENGTH, _criticalStrength);
      set => _criticalStrength = value;
    }

    public virtual int AttackRate {
      get => Math.Min(CONSTS.MAX_ATTACKRATE, _attackRate);
      set => _attackRate = value;
    }

    public virtual int AttackStrength {
      get => Math.Min(CONSTS.MAX_STRENGTH, _attackStrength);
      set => _attackStrength = value;
    }

    public virtual int AttackSpeed {
      get => Math.Min(CONSTS.MAX_ATTACKSPEED, _attackSpeed);
      set => _attackSpeed = value;
    }

    public bool IsCritical { set; get; }
    public bool IsMagic { set; get; }
    public int Power { set; get; }

    private int _criticalChance;
    private int _criticalStrength;
    private int _attackRate;
    private int _attackStrength;
    private int _attackSpeed;

  }
}

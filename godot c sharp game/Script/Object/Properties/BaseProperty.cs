using godotcsharpgame.Database.Attribute;

namespace godotcsharpgame.Script.Object.Properties {
  public class BaseProperty {
    
    [Property("CriticalChance", Global.PROP_TYPE.ATTACK)]
    public virtual int CriticalChance {
      get => _criticalChance;
      set => _criticalChance = value;
    }
    [Property("CriticalStrength", Global.PROP_TYPE.ATTACK)]
    public virtual int CriticalStrength {
      get => _criticalStrength;
      set => _criticalStrength = value;
    }
    [Property("AttackSpeed", Global.PROP_TYPE.ATTACK)]
    public virtual int AttackSpeed {
      get => _attackSpeed;
      set => _attackSpeed = value;
    }
    [Property("AttackRate", Global.PROP_TYPE.ATTACK)]
    public virtual int AttackRate {
      get => _attackRate;
      set => _attackRate = value;
    }

    [Property("Ac0", Global.PROP_TYPE.DEFENCE)]
    public int Ac0 {
      get => _ac0;
      set {
        _ac0 = value;
        PropertyChanged("Ac0", value);
      }
    }

    [Property("Ac1", Global.PROP_TYPE.DEFENCE)]
    public int Ac1 {
      get => _ac1;
      set {
        _ac1 = value;
        PropertyChanged("Ac1", value);
      }
    }

    [Property("Mac0", Global.PROP_TYPE.DEFENCE)]
    public int Mac0 {
      get => _mac0;
      set {
        _mac0 = value;
        PropertyChanged("Mac0", value);
      }
    }

    [Property("Mac1", Global.PROP_TYPE.DEFENCE)]
    public int Mac1 {
      get => _mac1;
      set {
        _mac1 = value;
        PropertyChanged("Mac1", value);
      }
    }

    [Property("Dc0", Global.PROP_TYPE.ATTACK)]
    public int Dc0 {
      get => _dc0;
      set {
        _dc0 = value;
        PropertyChanged("Dc0", value);
      }
    }

    [Property("Dc1", Global.PROP_TYPE.ATTACK)]
    public int Dc1 {
      get => _dc1;
      set {
        _dc1 = value;
        PropertyChanged("Dc1", value);
      }
    }

    [Property("Mc0", Global.PROP_TYPE.ATTACK)]
    public int Mc0 {
      get => _mc0;
      set {
        _mc0 = value;
        PropertyChanged("Mc0", value);
      }
    }

    [Property("Mc1", Global.PROP_TYPE.ATTACK)]
    public int Mc1 {
      get => _mc1;
      set {
        _mc1 = value;
        PropertyChanged("Mc1", value);
      }
    }

    [Property("Sc0", Global.PROP_TYPE.ATTACK)]
    public int Sc0 {
      get => _sc0;
      set {
        _sc0 = value;
        PropertyChanged("Sc0", value);
      }
    }

    [Property("Sc1", Global.PROP_TYPE.ATTACK)]
    public int Sc1 {
      get => _sc1;
      set {
        _sc1 = value;
        PropertyChanged("Sc1", value);
      }
    }

    [Property("Hp0", Global.PROP_TYPE.STAT)]
    public int Hp0 {
      get => _hp0;
      set {
        _hp0 = value;
        PropertyChanged("Hp0", value);
      }
    }

    [Property("Hp1", Global.PROP_TYPE.STAT)]
    public int Hp1 {
      get => _hp1;
      set {
        _hp1 = value;
        PropertyChanged("Hp1", value);
      }
    }

    [Property("Mp0", Global.PROP_TYPE.STAT)]
    public int Mp0 {
      get => _mp0;
      set {
        _mp0 = value;
        PropertyChanged("Mp0", value);
      }
    }

    [Property("Mp1", Global.PROP_TYPE.STAT)]
    public int Mp1 {
      get => _mp1;
      set {
        _mp1 = value;
        PropertyChanged("Mp1", value);
      }
    }
    
    public delegate void PlayerPropertyChange(string propName, object value);
    public event PlayerPropertyChange OnPropertyChanged;

    protected void PropertyChanged(string propName, object value) {
      OnPropertyChanged?.Invoke(propName, value);
    }
    
    private int _ac0;
    private int _ac1;
    private int _mac0;
    private int _mac1;
    private int _dc0;
    private int _dc1;
    private int _mc0;
    private int _mc1;
    private int _sc0;
    private int _sc1;
    private int _hp0;
    private int _hp1;
    private int _mp0;
    private int _mp1;
    private int _criticalChance;
    private int _criticalStrength;
    private int _attackSpeed;
    private int _attackRate;
  }
}

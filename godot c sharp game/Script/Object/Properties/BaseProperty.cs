using godotcsharpgame.Database.Attribute;

namespace godotcsharpgame.Script.Object.Properties {
  public class BaseProperty {
    
    [Property("CriticalChance", Global.PROP_TYPE.ATTACK)]
    public virtual int CriticalChance {
      get => _criticalChance;
      set => _criticalChance = value;
    }
    [Property("CriticalStrength", Global.PROP_TYPE.ATTACK)]
    public virtual float CriticalStrength {
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
    public float Ac0 {
      get => _ac0;
      set {
        _ac0 = value;
        PropertyChanged("Ac0", value);
      }
    }

    [Property("Ac1", Global.PROP_TYPE.DEFENCE)]
    public float Ac1 {
      get => _ac1;
      set {
        _ac1 = value;
        PropertyChanged("Ac1", value);
      }
    }

    [Property("Mac0", Global.PROP_TYPE.DEFENCE)]
    public float Mac0 {
      get => _mac0;
      set {
        _mac0 = value;
        PropertyChanged("Mac0", value);
      }
    }

    [Property("Mac1", Global.PROP_TYPE.DEFENCE)]
    public float Mac1 {
      get => _mac1;
      set {
        _mac1 = value;
        PropertyChanged("Mac1", value);
      }
    }

    [Property("Dc0", Global.PROP_TYPE.ATTACK)]
    public float Dc0 {
      get => _dc0;
      set {
        _dc0 = value;
        PropertyChanged("Dc0", value);
      }
    }

    [Property("Dc1", Global.PROP_TYPE.ATTACK)]
    public float Dc1 {
      get => _dc1;
      set {
        _dc1 = value;
        PropertyChanged("Dc1", value);
      }
    }

    [Property("Mc0", Global.PROP_TYPE.ATTACK)]
    public float Mc0 {
      get => _mc0;
      set {
        _mc0 = value;
        PropertyChanged("Mc0", value);
      }
    }

    [Property("Mc1", Global.PROP_TYPE.ATTACK)]
    public float Mc1 {
      get => _mc1;
      set {
        _mc1 = value;
        PropertyChanged("Mc1", value);
      }
    }

    [Property("Sc0", Global.PROP_TYPE.ATTACK)]
    public float Sc0 {
      get => _sc0;
      set {
        _sc0 = value;
        PropertyChanged("Sc0", value);
      }
    }

    [Property("Sc1", Global.PROP_TYPE.ATTACK)]
    public float Sc1 {
      get => _sc1;
      set {
        _sc1 = value;
        PropertyChanged("Sc1", value);
      }
    }

    [Property("Hp0", Global.PROP_TYPE.STAT)]
    public float Hp0 {
      get => _hp0;
      set {
        _hp0 = value;
        PropertyChanged("Hp0", value);
      }
    }

    [Property("Hp1", Global.PROP_TYPE.STAT)]
    public float Hp1 {
      get => _hp1;
      set {
        _hp1 = value;
        PropertyChanged("Hp1", value);
      }
    }

    [Property("Mp0", Global.PROP_TYPE.STAT)]
    public float Mp0 {
      get => _mp0;
      set {
        _mp0 = value;
        PropertyChanged("Mp0", value);
      }
    }

    [Property("Mp1", Global.PROP_TYPE.STAT)]
    public float Mp1 {
      get => _mp1;
      set {
        _mp1 = value;
        PropertyChanged("Mp1", value);
      }
    }
    
    public delegate void PlayerPropertyChange(string propName, float value);
    public event PlayerPropertyChange OnPropertyChanged;

    protected void PropertyChanged(string propName, float value) {
      OnPropertyChanged?.Invoke(propName, value);
    }

    public float AttackMin() {
      return Dc0 + Mc0 + Sc0;
    }
    
    public float AttackMax() {
      return Dc1 + Mc1 + Sc1;
    }

    private float _ac0;
    private float _ac1;
    private float _mac0;
    private float _mac1;
    private float _dc0;
    private float _dc1;
    private float _mc0;
    private float _mc1;
    private float _sc0;
    private float _sc1;
    private float _hp0;
    private float _hp1;
    private float _mp0;
    private float _mp1;
    private int _criticalChance;
    private float _criticalStrength;
    private int _attackSpeed;
    private int _attackRate;
  }
}

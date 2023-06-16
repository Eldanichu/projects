namespace godotcsharpgame.Script.Object.Monster.Base.Obj {
  public class MonsterProps {
    public string Uid {
      get => _uid;
      set => _uid = value;
    }

    public string Id {
      get => _id;
      set => _id = value;
    }

    public string Name {
      get => _name;
      set => _name = value;
    }

    public int Type {
      get => _type;
      set => _type = value;
    }


    public long Level {
    get => _level;
    set {
      _level = value;
      PropertyChanged("Level",value);
    }
  }

  public long Ac0 {
    get => _ac0;
    set {
      _ac0 = value;
      PropertyChanged("Ac0",value);
    }
  }

  public long Ac1 {
    get => _ac1;
    set {
      _ac1 = value;
      PropertyChanged("Ac1",value);
    }
  }

  public long Mac0 {
    get => _mac0;
    set {
      _mac0 = value;
      PropertyChanged("Mac0",value);
    }
  }

  public long Mac1 {
    get => _mac1;
    set {
      _mac1 = value;
      PropertyChanged("Mac1",value);
    }
  }

  public long Dc0 {
    get => _dc0;
    set {
      _dc0 = value;
      PropertyChanged("Dc0",value);
    }
  }

  public long Dc1 {
    get => _dc1;
    set {
      _dc1 = value;
      PropertyChanged("Dc1",value);
    }
  }

  public long Mc0 {
    get => _mc0;
    set {
      _mc0 = value;
      PropertyChanged("Mc0",value);
    }
  }

  public long Mc1 {
    get => _mc1;
    set {
      _mc1 = value;
      PropertyChanged("Mc1",value);
    }
  }

  public long Hp0 {
    get => _hp0;
    set {
      _hp0 = value;
      PropertyChanged("Hp0",value);
    }
  }

  public long Hp1 {
    get => _hp1;
    set {
      _hp1 = value;
      PropertyChanged("Hp1",value);
    }
  }

  public long Mp0 {
    get => _mp0;
    set {
      _mp0 = value;
      PropertyChanged("Mp0",value);
    }
  }

  public long Mp1 {
    get => _mp1;
    set {
      _mp1 = value;
      PropertyChanged("Mp1",value);
    }
  }


  private string _uid;
  private string _id;
  private string _name;
  private int _type;
  private long _level;
  private long _ac0;
  private long _ac1;
  private long _mac0;
  private long _mac1;
  private long _dc0;
  private long _dc1;
  private long _mc0;
  private long _mc1;
  private long _hp0;
  private long _hp1;
  private long _mp0;
  private long _mp1;

  
  public delegate void MonPropertyChange(string propName,object value);
  public event MonPropertyChange OnPropertyChanged;

  private void PropertyChanged(string propName,object value) {
    OnPropertyChanged?.Invoke(propName,value);
  }
  }
}

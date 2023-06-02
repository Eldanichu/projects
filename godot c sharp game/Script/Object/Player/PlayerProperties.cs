﻿using godotcsharpgame.Database.Attribute;

public class PlayerProperties {
  public delegate void PlayerPropertyChange(string propName,object value);
  public event PlayerPropertyChange OnPropertyChanged;

  public string PName {
    get => _pName;
    set => _pName = value;
  }

  public string ClassName {
    get => _className;
    set {
      _className = value;
      PropertyChanged("ClassName",value);
    }
  }

  public int ClassType {
    get => _classType;
    set {
      _classType = value;
      PropertyChanged("ClassType",value);
    }
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

  public long Sc0 {
    get => _sc0;
    set {
      _sc0 = value;
      PropertyChanged("Sc0",value);
    }
  }

  public long Sc1 {
    get => _sc1;
    set {
      _sc1 = value;
      PropertyChanged("Sc1",value);
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

  public long Exp0 {
    get => _exp0;
    set {
      _exp0 = value;
      PropertyChanged("Exp0",value);
    }
  }

  public long Exp1 {
    get => _exp1;
    set {
      _exp1 = value;
      PropertyChanged("Exp1",value);
    }
  }

  private string _pName;
  private string _className;
  private int _classType;
  private long _level;
  private long _ac0;
  private long _ac1;
  private long _mac0;
  private long _mac1;
  private long _dc0;
  private long _dc1;
  private long _mc0;
  private long _mc1;
  private long _sc0;
  private long _sc1;
  private long _hp0;
  private long _hp1;
  private long _mp0;
  private long _mp1;
  private long _exp0;
  private long _exp1;

  private void PropertyChanged(string propName,object value) {
    OnPropertyChanged?.Invoke(propName,value);
  }
}

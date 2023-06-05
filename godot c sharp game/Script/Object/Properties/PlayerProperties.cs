using godotcsharpgame.Database.Attribute;
using godotcsharpgame.Script.Object.Properties;

public class PlayerProperties : BaseProperty {
  public string PName {
    get => _pName;
    set => _pName = value;
  }

  public string ClassName {
    get => _className;
    set {
      _className = value;
      PropertyChanged("ClassName", value);
    }
  }

  public byte ClassType {
    get => _classType;
    set {
      _classType = value;
      PropertyChanged("ClassType", value);
    }
  }

  [Property("Level", Global.PROP_TYPE.STAT)]
  public int Level {
    get => _level;
    set {
      _level = value;
      PropertyChanged("Level", value);
    }
  }

  [Property("Exp0", Global.PROP_TYPE.STAT)]
  public int Exp0 {
    get => _exp0;
    set {
      _exp0 = value;
      PropertyChanged("Exp0", value);
    }
  }

  [Property("Exp1", Global.PROP_TYPE.STAT)]
  public int Exp1 {
    get => _exp1;
    set {
      _exp1 = value;
      PropertyChanged("Exp1", value);
    }
  }

  public override int AttackRate { get; set; } = 45;
  public override int AttackSpeed { get; set; } = 100;
  public override int CriticalChance { get; set; } = 10;
  public override int CriticalStrength { get; set; } = 11;
  
  private string _pName;
  private string _className;
  private byte _classType;
  private int _level;
  private int _exp0;
  private int _exp1;

}

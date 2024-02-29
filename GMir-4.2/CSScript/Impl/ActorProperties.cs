using System;
using System.Reflection;
using NSBaseProperties;

namespace GMir4.Empty.CSScript.Impl; 

public class ActorProperties : IActorProperties {
  private int _hp;
  private int _hp_max;
  private int _mp;
  private int _mp_max;
  private int _expr;
  private int _expr_max;
  private int _level;
  private int _ac;
  private int _ac_max;
  private int _dc;
  private int _dc_max;
  private int _sc;
  private int _sc_max;
  private int _mac;
  private int _lck;
  private int _mar;
  private int _cdr;
  [ActorProperties("HP","血量")]
  public int hp {
    get => _hp;
    set {
      if (value <= 0) {
        value = 0;
      }

      if (value >= hp_max) {
        value = hp_max;
      }
      
      _hp = value;
    } 
  }
  public int hp_max {
    get {
      if (_hp_max <= 0) {
        _hp_max = 1;
      }

      return _hp_max;
    }
    set => _hp_max = value;
  }
  public int mp {
    get => _mp;
    set {
      if (value <= 0) {
        value = 0;
      }

      if (value >= mp_max) {
        value = mp_max;
      }
      
      _mp = value;
    } 
  }
  public int mp_max {
    get {
      if (_mp_max <= 0) {
        _mp_max = 1;
      }

      return _mp_max;
    }
    set => _mp_max = value;
  }
  public int expr {
    get => _expr;
    set {
      if (value <= 0) {
        value = 0;
      }

      if (value >= expr_max) {
        value = expr_max;
      }
      
      _expr = value;
    } 
  }
  public int expr_max {
    get {
      if (_expr_max <= 0) {
        _expr_max = 1;
      }

      return _expr_max;
    }
    set => _expr_max = value;
  }
  public int level { get; set; }
  public int ac { get; set; }
  public int ac_max { get; set; }
  public int dc { get; set; }
  public int dc_max { get; set; }
  public int sc { get; set; }
  public int sc_max { get; set; }
  public int mac { get; set; }
  public int lck { get; set; }
  public int mar { get; set; }
  public int cdr { get; set; }

  public ActorProperties() {
    // var _type = this.GetType();
    // var propties = _type.GetProperties(BindingFlags.Instance | BindingFlags.Public);
    //
    // foreach (var prop in propties) {
    //   var attr = prop.GetCustomAttribute<ActorPropertiesAttribute>();
    //   if (attr == null) continue;
    //   Console.WriteLine(attr);
    // }
    // var v =_type.GetProperty("hp");
    // // var _ph = _type.GetProperty("hp");
    // // var v = _ph.GetValue(this);
    // Console.WriteLine(v);
  }
  
  public float Percentage(int pMin, int pMax) {
    var _pmin = pMin * 1.0f;
    var _pmax = pMax * 1.0f;
    if (_pmax <= 0) {
      _pmax = 1;
    }

    return _pmin / _pmax * 100;
  }

  public IBaseProperties GetBase() {
    return this;
  }

  public IOtherProperties GetOther() {
    return this;
  }
}

public class ActorPropertiesAttribute : Attribute {
  
  private string _Name;
  private string _CnName;
  public ActorPropertiesAttribute(string name,string cnName) {
    _Name = name;
    _CnName = cnName;
  }
}
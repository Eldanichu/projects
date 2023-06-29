using System;
using Godot;
using godotcsharpgame.Script.Interface.Damage;
using godotcsharpgame.Script.Object.Properties;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Damage {
  public class DamageObject : IDamage {
    public float dMax { get; set; }
    public float dMin { get; set; }
    public float Power { private set; get; }
    public bool IsCriticalPower { private set; get; }

    private Random _rnd;
    private BaseProperty _property;
    public DamageObject(BaseProperty property = null) {
      _rnd = new Random();
      _property = property;
    }

    public void GetPower() {
      if (!IsHit()) {
        return;
      }
      if (_property != null) {
        dMax = _property.AttackMax();
        dMin = _property.AttackMin();
      }
      
      Power += _rnd.R(dMax, dMin);
      if (IsCritical()) {
        Power *= _property.CriticalStrength;
        IsCriticalPower = true;
      }
    }

    private bool IsHit() {
      return _rnd.Possible(_property.AttackRate);
    }

    private bool IsCritical() {
      return _rnd.Possible(_property.CriticalChance);
    }
  }
}

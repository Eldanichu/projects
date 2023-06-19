using System;
using Godot;
using godotcsharpgame.Script.Object.Properties;

namespace godotcsharpgame.Script.Object.Damage {
  public class DamageObject {
    public PlayerClass.PlayerClass PlayerClass { set; get; }
    public bool IsCritical { set; get; }
    public bool IsMagic { get; }
    public BaseProperty Props { set; get; }
    public int DMin { get; set; }
    public int DMax { get; set; }
    public int Power { set; get; }

    private Random _rnd;
    public DamageObject() {
      _rnd = new Random();
    }

    public void GetPower() {
      if (!Hit()) {
        Power = 0;
        return;
      }

      CriticalHit();
      Power += _rnd.R(DMin, DMax);
      if (!IsCritical) return;
      Power += 1;
      Power = (int)Math.Round(Power * 1.1);
    }

    private bool Hit() {
      return _rnd.I(100 - Props.AttackRate) < Props.AttackRate;
    }

    private void CriticalHit() {
      var _critical = _rnd.I(100 - Props.CriticalChance) < Props.CriticalChance;
      IsCritical = _critical;
    }
  }
}

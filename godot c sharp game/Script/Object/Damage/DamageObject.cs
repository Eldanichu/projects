using System;
using Godot;
using godotcsharpgame.Script.Object.Properties;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Damage {
  public class DamageObject {
    public float dMax { get; set; }
    public float dMin { get; set; }
    public float Power { private set; get; }
    public bool IsCriticalPower { private set; get; }

    private Random _rnd;
    public DamageObject() {
      _rnd = new Random();
    }

    public void GetPower() {
      if (!IsHit()) {
        return;
      }
      Power += _rnd.R(dMax, dMin);
      if (IsCritical()) {
        Power *= 1.2f;
        IsCriticalPower = true;
      }
    }

    private bool IsHit() {
      return _rnd.Possible(55);
    }

    private bool IsCritical() {
      return _rnd.Possible(25);
    }
  }
}

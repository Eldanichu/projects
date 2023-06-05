using System.Collections.Generic;
using Godot;
using godotcsharpgame.Script.Interface.Damage;

namespace godotcsharpgame.Script.Object.Damage {
  public class DamageProcessor : DamageType,IDamageProcessor {

    public int DMin { get; set; }
    public int DMax { get; set; }
    private Random _rng = new Random();
    
    public DamageProcessor() {
      
    }
    
    public virtual void GetPower() {
      if (Hit()) {
        Power += _rng.R(DMin, DMax);
      }
      if (IsCritical) {
        Power *= CriticalStrength;
      }
    }
    
    public bool Hit() {
      var isHit = _rng.I(100 - AttackRate) == 0;
      return isHit;
    }
    public void CriticalHit() {
      var isCritical = _rng.I(100 - CriticalChance) == 0;

      IsCritical = isCritical;
    }
  }
}

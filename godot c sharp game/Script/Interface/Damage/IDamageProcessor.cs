using System.Collections.Generic;
using godotcsharpgame.Script.Object.Damage;

namespace godotcsharpgame.Script.Interface.Damage {
  public interface IDamageProcessor {
    int DMin { set; get; }
    int DMax { set; get; }
    void GetPower();
    bool Hit();
    void CriticalHit();
  }
}

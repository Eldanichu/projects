using Godot;
using godotcsharpgame.Script.Interface.Damage;

namespace godotcsharpgame.Script.Object.Damage{
  public class DamageObject : DamageProcessor,IDamage {

    public Node target { get; set; }
    
  }
}
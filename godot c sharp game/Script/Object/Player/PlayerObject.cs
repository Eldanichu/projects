using System.Reflection;
using Godot;
using Godot.Collections;
using godotcsharpgame.Database.Attribute;

public class PlayerObject : PlayerClass, IPlayer {
  public Node PlayerNode { get; }
  public PlayerProperties Props { get; }

  public PlayerObject(Node playerNode) {
    PlayerNode = playerNode;
    Props = new PlayerProperties();
  }

  public bool Dead() {
    if (Props.hp0 > 0) return false;
    Props.hp0 = 0;
    return true;
  }

  public void LevelUp() {
    Props.Level += 1;
    ApplyProperties(this);
    Props.exp0 = 0;
    Props.hp0 = Props.hp1;
    Props.mp0 = Props.mp1;
  }

  public void Attack() {

  }

  public void UseItem() {

  }

  public void TakeDamage() {

  }

  public Dictionary GetObject() {
    var dict = new Dictionary();
    var _type = typeof(PlayerProperties);
    var props = _type.GetProperties(BindingFlags.Instance | BindingFlags.Public);

    foreach (var p in props) {
      var attr = p.GetCustomAttribute<PropertyAttribute>();
      if (attr == null) continue;
      var obj = p.GetValue(Props);
      dict.Add(attr.Name, obj);
    }

    return dict;
  }
}

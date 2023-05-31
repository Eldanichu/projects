using System.Collections.Generic;
using System.Reflection;
using Godot;
using godotcsharpgame.Database.Attribute;

public abstract class BasePlayer : PlayerClass, IPlayer, IPlayerAction {
  public virtual Node node { get; set; }
  public virtual List<Node> Targets { get; set; }
  public virtual PlayerProperties props { get; set; }
  public virtual List<string> Inventory { get; set; }

  protected BasePlayer() {
    Inventory = new List<string>();
    props = new PlayerProperties();
  }

  public void GiveItem(Item item) {

  }
  
  public int TakeItem(string ItemId) {
    return 0;
  }
  
  public void AddSkill(Skill skill) {

  }
  
  public bool DeleteSkill(string skillId) {

    return false;
  }
  
  public Dictionary<string,object> GetObject() {
    var dict = new Dictionary<string,object>();
    var _type = typeof(PlayerProperties);
    var props = _type.GetProperties(BindingFlags.Instance | BindingFlags.Public);
  
    foreach (var p in props) {
      var attr = p.GetCustomAttribute<PropertyAttribute>();
      if (attr == null) continue;
      var obj = p.GetValue(props);
      dict.Add(attr.Name, obj);
    }
  
    return dict;
  }
}

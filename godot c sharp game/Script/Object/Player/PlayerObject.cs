  using System;
  using System.Reflection;
  using Godot;
  using Godot.Collections;
  using godotcsharpgame.Script.Util;
  using Object = Godot.Object;

  public class PlayerObject : PlayerClass,IPlayer  {
    public Node PlayerNode { set; get; }
    
    public string PName { get; set; }
    public string ClassName { get; set; }
    public int ClassType { get; set; }
    public long Level { get; set; }
    public long ac0 { get; set; }
    public long ac1 { get; set; }
    public long hp0 { get; set; }
    public long hp1 { get; set; }
    public long mp0 { get; set; }
    public long mp1 { get; set; }

    public PlayerObject() {

    }

    public Dictionary GetObject() {
      var dict = new Dictionary();
      var _type = typeof(PlayerObject);
      var props = _type.GetProperties(BindingFlags.Instance | BindingFlags.Public);
      
      foreach (var p in props) {
        var obj = p.GetValue(this);
        dict.Add(p.Name, obj);
      }
      
      return dict;
    }

    public bool Dead() {
     
      return false;
    }

    public void LevelUp() {
      Level += 1;
      hp0 = hp1;
      mp0 = mp1;
    }

    public void Attack() {
      
    }

    public void UseItem() {
      
    }

    public void Spell() {
  
    }

    public void TakeDamage() {
     
    }
  }


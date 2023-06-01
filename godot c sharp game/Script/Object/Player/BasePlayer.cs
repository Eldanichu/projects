using System;
using System.Collections.Generic;
using System.Reflection;
using Godot;
using godotcsharpgame.Database.Attribute;

public abstract class BasePlayer : PlayerClass, IPlayer, IPlayerAction, IPlayerEvent {
  public virtual Node node { get; set; }
  public virtual List<Node> Targets { get; set; }
  public virtual PlayerProperties props { get; set; }
  public virtual List<string> Inventory { get; set; }
  public Dictionary<string, Item> Equipment { get; set; }
  protected BasePlayer() {
    Inventory = new List<string>();
    props = new PlayerProperties();
  }
  
  public void GainExp(int exps) {
    if (props.exp0 < props.exp1 && !Dead()) {
      return;
    }
    props.exp0 += exps;
    LevelUp();
  }
  public void GainItems(List<Item> items) {
    
  }
  public void LevelUp() {
    props.hp0 = props.hp1;
    props.mp0 = props.mp1;
    props.exp0 = 0;
  }
  public bool Dead() {
    if (props.hp0 <= 0) {
      props.hp0 = 0;
      return true;
    }
    return false;
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
  public void GiveExp(int value = 0) {
    GainExp(value);
  }
  public void GiveHp(int value = 0) {
    props.hp0 += value;
    if (props.hp0 <= 0) {
      props.hp0 = 0;
      Dead();
    }
  }
  public void GiveMp(int value = 0) {
    props.mp0 += value;
    if (props.mp0 <= 0) {
      props.mp0 = 0;
    }
  }
  public void CalculateProperties() {
    props.PName = "";
    var cg = new Global.ClassGrowth() {
      level = props.Level
    };
    cg.apply((Global.CLASS_TYPE)props.ClassType);
    props.hp1 = cg.HP;
    props.mp1 = cg.MP;
    props.exp1 = cg.EXP;
    
    props.ac0 = cg.Ac0;
    props.ac1 = cg.Ac1;
    props.mac0 = cg.Mac0;
    props.mac1 = cg.Mac1;
    
    props.dc0 = cg.Dc0;
    props.dc1 = cg.Dc1;
    props.sc0 = cg.Sc0;
    props.sc1 = cg.Sc1;
    props.mc0 = cg.Mc0;
    props.mc1 = cg.Mc1;
  }
  public Dictionary<string, object> GetObject() {
    var dict = new Dictionary<string, dynamic>() {
      {"ac0",props.ac0},
      {"ac1",props.ac1},
      {"sc0",props.sc0},
      {"sc1",props.sc1},
      {"mc0",props.mc0},
      {"mc1",props.mc1},
      {"dc0",props.dc0},
      {"dc1",props.dc1},
      {"mac0",props.mac0},
      {"mac1",props.mac1},
      {"Level",props.Level},
      {"PName",props.PName},
      {"ClassType",props.ClassType},
      {"ClassName",props.ClassName},
      {"exp0",props.exp0},
      {"exp1",props.exp1},
      {"mp0",props.mp0},
      {"mp1",props.mp1},
      {"hp0",props.hp0},
      {"hp1",props.hp1},
    };
    return dict;
  }
}

using System.Collections.Generic;
using Godot;
using godotcsharpgame.Database.Attribute;
using godotcsharpgame.Script.Interface.Player;
using godotcsharpgame.Script.Object.Item;
using godotcsharpgame.Script.Object.PlayerClass;
using godotcsharpgame.Script.Object.Properties;
using godotcsharpgame.Script.Object.Skill;
using godotcsharpgame.Script.Util;

public class PlayerObject : IPlayer {
  public delegate void PlayerAbility(Global.PLAYER_ABILITY state, decimal amount);
  public Node node { get; set; }
  public List<Node> Targets { get; set; }
  public PlayerProperties props { get; set; }
  public PlayerClass PlayerClass { get; set; }
  public List<string> Inventory { get; set; }
  public Dictionary<string, Item> Equipment { get; set; }
  public PlayerObject(Global.CLASS_TYPE classType) {
    Inventory = new List<string>();
    props = new PlayerProperties();
    props.Level = 1;
    switch (classType) {
      case Global.CLASS_TYPE.warrior:
        PlayerClass = new WarClass();
        break;
      case Global.CLASS_TYPE.wizard:
        PlayerClass = new WizClass();
        break;
      case Global.CLASS_TYPE.tao:
        PlayerClass = new TaoClass();
        break;
    }
    PlayerClass.props = props;
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
    int amount = value;
    while (props.Exp1 < amount) {
      props.Exp0 += amount;
      amount -= props.Exp1;
      props.Exp0 = amount;
      LevelUp();
    }
  }
  public void GiveHp(int value = 0) {
    props.Hp0 += value;
    if (Dead()) {
      return;
    }
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.HP, value);
  }
  public void GiveMp(int value = 0) {
    props.Mp0 += value;
    if (props.Mp0 <= 0) props.Mp0 = 0;
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.MP, value);
  }

  public void GainExp(int exps) {
    if (Dead()) return;
    props.Exp0 += exps;
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.EXP, exps);
  }
  public void GainItems(List<Item> items) {

  }
  public void LevelUp() {
    props.Level += 1;
    PlayerClass.Calculate();
    RestoreStat();
    L.t($"{props.Level}");
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.LEVEL);
  }
  public bool Dead() {
    if (props.Hp0 <= 0) {
      props.Hp0 = 0;
      OnPlayerAbilityChange(Global.PLAYER_ABILITY.DEAD);
      return true;
    }
    return false;
  }

  public void RestoreStat() {
    props.Hp0 = props.Hp1;
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.HP);
    props.Mp0 = props.Mp1;
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.MP);
  }
  public event PlayerAbility AbilityChanged;
  private void OnPlayerAbilityChange(Global.PLAYER_ABILITY state, decimal amount = -4) {
    AbilityChanged?.Invoke(state, amount);
  }
  
  public Dictionary<string, object> GetProps(Global.PROP_TYPE type) {
    var av = new AttributeOfValue<PropertyAttribute, PlayerProperties> {
      Type = type
    };
    var dict = av.GetProps(props);
    return dict;
  }
}

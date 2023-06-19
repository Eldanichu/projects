using System.Collections.Generic;
using Godot;
using godotcsharpgame.Database.Attribute;
using godotcsharpgame.Script.Object.Properties;
using godotcsharpgame.Script.Object.Skill;

public class PlayerObject {
  public delegate void PlayerAbility(Global.PLAYER_ABILITY state, decimal amount);
  public Node node { get; set; }
  public List<Node> Targets { get; set; }
  public PlayerProperties props { get; set; }
  public List<string> Inventory { get; set; }
  public Dictionary<string, Item> Equipment { get; set; }
  public PlayerObject() {
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
  public void GiveExp(int value = 0) {
    GainExp(value);
  }
  public void GiveHp(int value = 0) {
    props.Hp0 += value;
    if (props.Hp0 <= 0) {
      props.Hp0 = 0;
      Dead();
    }
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.HP, value);
  }
  public void GiveMp(int value = 0) {
    props.Mp0 += value;
    if (props.Mp0 <= 0) props.Mp0 = 0;
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.MP, value);
  }

  public void GainExp(int exps) {
    if (props.Exp0 < props.Exp1 && !Dead()) return;
    props.Exp0 += exps;
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.EXP, exps);
    LevelUp();
  }
  public void GainItems(List<Item> items) {

  }
  public void LevelUp() {
    props.Level += 1;
    props.Hp0 = props.Hp1;
    props.Mp0 = props.Mp1;
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

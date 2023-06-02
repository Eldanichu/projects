using System.Collections.Generic;
using Godot;
using godotcsharpgame.Database.Attribute;
using godotcsharpgame.Script.Util;

public abstract class BasePlayer : PlayerClass, IPlayer, IPlayerAction, IPlayerEvent {
  public delegate void PlayerAbility(Global.PLAYER_ABILITY state, decimal amount);

  protected BasePlayer() {
    Inventory = new List<string>();
    props = new PlayerProperties();
  }
  public virtual Node node { get; set; }
  public virtual List<Node> Targets { get; set; }
  public virtual PlayerProperties props { get; set; }
  public virtual List<string> Inventory { get; set; }
  public Dictionary<string, Item> Equipment { get; set; }
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
  public virtual void LevelUp() {
    props.Level += 1;
    
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
  public Dictionary<string, object> GetProps() {
    var av = new AttributeOfValue<PropertyAttribute, PlayerProperties>();
    var dict = av.GetProps(props);
    return dict;
  }
}

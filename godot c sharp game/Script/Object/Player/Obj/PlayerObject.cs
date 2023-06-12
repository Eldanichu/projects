using System.Collections.Generic;
using Godot;
using godotcsharpgame.Database.Attribute;
using godotcsharpgame.Script.Object.Damage;
using godotcsharpgame.Script.Object.Monster.Base.Obj;
using godotcsharpgame.Script.Object.Player.Obj.Base.State.Event.Action;

public class PlayerObject : PlayerAction, IPlayer {

  public Node node { get; set; }
  public List<Node> Targets { get; set; }
  public PlayerProperties props { get; set; }
  public List<string> Inventory { get; set; }
  public Dictionary<string, Item> Equipment { get; set; }
  public PlayerClass PlayerClass { set; get; }
  

  public PlayerObject() {
    Inventory = new List<string>();
    props = new PlayerProperties();
    Object = node;
  }
  public override void GiveItem(Item item) {
    
  }
  public override int TakeItem(string ItemId) {
    return 0;
  }
  public override void AddSkill(Skill skill) {

  }
  public override bool DeleteSkill(string skillId) {

    return false;
  }
  public override void GiveExp(int value = 0) {
    GainExp(value);
  }
  public override void GiveHp(int value = 0) {
    props.Hp0 += value;
    if (props.Hp0 <= 0) {
      props.Hp0 = 0;
      Dead();
    }
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.HP, value);
  }
  public override void GiveMp(int value = 0) {
    props.Mp0 += value;
    if (props.Mp0 <= 0) props.Mp0 = 0;
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.MP, value);
  }

  public override void GainExp(int exps) {
    if (props.Exp0 < props.Exp1 && !Dead()) return;
    props.Exp0 += exps;
    OnPlayerAbilityChange(Global.PLAYER_ABILITY.EXP, exps);
    LevelUp();
  }
  public override void GainItems(List<Item> items) {

  }
  public virtual void LevelUp() {
    props.Level += 1;
    CalculateProperties();
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
  public delegate void PlayerAbility(Global.PLAYER_ABILITY state, decimal amount);
  public event PlayerAbility AbilityChanged;
  private void OnPlayerAbilityChange(Global.PLAYER_ABILITY state, decimal amount = -4) {
    AbilityChanged?.Invoke(state, amount);
  }
  public Dictionary<string, object> GetProps(Global.PROP_TYPE type) {
    var av = new AttributeOfValue<PropertyAttribute, PlayerProperties>() {
      Type = type
    };
    var dict = av.GetProps(props);
    return dict;
  }

  public void CalculateProperties() {
    var cg = new PlayerGrowth() {
      PlayerClass = PlayerClass,
      props = props
    };
    cg.Calculate();
  }

  public override bool IsTargetObject(PlayerObject target) {
    target.Object = node;
    return true;
  }
  public override bool IsTargetObject(MonsterObject target) {
    throw new System.NotImplementedException();
  }
}

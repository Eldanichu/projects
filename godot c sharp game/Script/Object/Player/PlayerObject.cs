using System.Collections.Generic;
using Godot;
using godotcsharpgame.Script.Object.Damage;

public class PlayerObject : BasePlayer {
  public override Node node { get; set; }
  public override List<Node> Targets { get; set; }
  public PlayerClass PlayerClass { set; get; }
  
  public void CalculateProperties() {
    var cg = new PlayerGrowth() {
      PlayerClass = PlayerClass,
      props = props
    };
    cg.Calculate();
  }

  public override bool CanCast() {

    return base.CanCast();
  }
  
  public override void LevelUp() {
    base.LevelUp();
    CalculateProperties();
    props.Hp0 = props.Hp1;
    props.Mp0 = props.Mp1;
    props.Exp0 = 0;
  }
  public override void Attack(DamageObject damage) {
    if (Dead()) return;

  }

  public override void UseSkill(Skill skill) {
    if (Dead()) return;
    if (skill.MpReq > props.Mp0) return;
    //TODO cast the skill
  }
}

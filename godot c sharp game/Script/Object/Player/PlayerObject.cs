using System.Collections.Generic;
using Godot;

public class PlayerObject : BasePlayer {
  public override Node node { get; set; }
  public override List<Node> Targets { get; set; }

  public override void Attack(Damage damage) {
    if (Dead()) {
      return;
    }
    
  }

  public override void UseSkill(Skill skill) {
    if (Dead()) {
      return;
    }
    if (skill.MpReq > props.mp0) {
      return;
    }
    //TODO cast the skill
  }
  
}

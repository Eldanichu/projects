using Godot;
using godotcsharpgame.Script.Util;

public class PlayerClass : IPlayerClass {
  public Global.CLASS_TYPE classType { get; set; }
  
  public PlayerClass() {
  }

  public void ApplyProperties(PlayerObject player) {
    var cg = new Global.ClassGrowth() {
      level = player.Props.Level
    };
    cg.apply((Global.CLASS_TYPE)player.Props.ClassType);
    player.Props.hp1 = cg.HP;
    player.Props.mp1 = cg.MP;
    player.Props.exp1 = cg.EXP;
  }
  
  public void CastSkill(string skillId) {
    
  }
}

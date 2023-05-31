using Godot;
public class BaseSkill : SkillEvent,IBaseSkill {
  public decimal Cooldown { get; set; }
  public Timer Timer { get; set; }

  public BaseSkill() {
    
  }
  
  public void Cast() {
    throw new System.NotImplementedException();
  }
}

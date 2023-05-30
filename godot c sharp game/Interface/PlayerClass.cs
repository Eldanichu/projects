public class PlayerClass : Skill {
  protected enum CLASS_TYPE {
    warrior = 1,
    wizard = 2,
    tao = 3
  }

  protected void Tao(PlayerObject p) {
    p.ClassType = (int)PlayerClass.CLASS_TYPE.tao;  
    
  }

  protected void Wizard(PlayerObject p) {
    p.ClassType = (int)PlayerClass.CLASS_TYPE.wizard;
    
  }

  protected void Warrior(PlayerObject p) {
    p.ClassType = (int)PlayerClass.CLASS_TYPE.warrior;
    
  }
}


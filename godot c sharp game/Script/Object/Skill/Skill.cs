using System;
using Godot;
using Object = Godot.Object;

public class Skill : Object,ISkill {
  public Node skill { set; get; }
  public Timer timer;
  
  public Skill() {
   
  }

  public void HealSelf() {
    
  }
  
}

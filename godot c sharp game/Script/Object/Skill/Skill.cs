using System;
using Godot;
using Object = Godot.Object;

public class Skill : Node, ISkill {
  public string SkillId { get; set; }
  
  private Type _type;

  public Skill() {
  }

  public void FireBall() {
    throw new NotImplementedException();
  }
  public void MagicShield() {
    throw new NotImplementedException();
  }
  public void Lightnings() {
    throw new NotImplementedException();
  }
  public void ElectricLine() {
    throw new NotImplementedException();
  }
  public void Blizzard() {
    throw new NotImplementedException();
  }
  
  public void HealSelf() {
    var buff = new Buff();
    buff.HealBuff();
    AddChild(buff);
  }
  public void MultipleHeal() {
    throw new NotImplementedException();
  }
  public void SoulsBall() {
    throw new NotImplementedException();
  }
  public void MultipleSoulsBall() {
    throw new NotImplementedException();
  }
  public void SummonDog() {
    throw new NotImplementedException();
  }
  public void SummonSkeleton() {
    throw new NotImplementedException();
  }
  public void SummonLion() {
    throw new NotImplementedException();
  }
  
  public void BaseAttack() {
    throw new NotImplementedException();
  }
  public void HighRateAttack() {
    throw new NotImplementedException();
  }
  public void AggressiveAttack() {
    throw new NotImplementedException();
  }
  public void ArcAttack() {
    throw new NotImplementedException();
  }
  public void FireAttack() {
    throw new NotImplementedException();
  }
  public void CrashAttack() {
    throw new NotImplementedException();
  }
  public void GroundSticks() {
    throw new NotImplementedException();
  }
}

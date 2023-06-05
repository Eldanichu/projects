namespace godotcsharpgame.Script.Interface.Damage {
  public interface IDamageType {
    bool IsCritical { set; get; }
    bool IsMagic { set; get; }
    int CriticalChance { set; get; }
    int CriticalStrength { set; get; }
    int AttackRate { set; get; }
    int AttackStrength { set; get; }
    int AttackSpeed { set; get; }
    int Power { set; get; }
    
  }
}

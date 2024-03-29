﻿namespace godotcsharpgame.Script.Object.Properties {
  public class MonsterProperties : BaseProperty {
    public override int AttackRate { get; set; } = 45;
    public override int AttackSpeed { get; set; } = 100;
    public override int CriticalChance { get; set; } = 5;
    public override int CriticalStrength { get; set; } = 11;
  }
}

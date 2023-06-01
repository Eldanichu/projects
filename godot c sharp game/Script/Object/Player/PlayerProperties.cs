using godotcsharpgame.Database.Attribute;

public class PlayerProperties {

  [Property("PName")] public string PName { get; set; }
  [Property("ClassName")] public string ClassName { get; set; }
  [Property("ClassType")] public int ClassType { get; set; }
  [Property("Level")] public long Level { get; set; }
  [Property("ac0")] public long ac0 { get; set; }
  [Property("ac1")] public long ac1 { get; set; }
  [Property("hp0")] public long hp0 { get; set; }
  [Property("hp1")] public long hp1 { get; set; }
  [Property("mp0")] public long mp0 { get; set; }
  [Property("mp1")] public long mp1 { get; set; }
  [Property("exp0")] public long exp0 { get; set; }
  [Property("exp1")] public long exp1 { get; set; }
}

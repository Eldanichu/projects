using System;

namespace godotcsharpgame.Database.Attribute {
  [AttributeUsage(AttributeTargets.Property)]
  public class PropertyAttribute : System.Attribute {
    public string Name { get; }
    public Global.PROP_TYPE Type { get; }
    public PropertyAttribute(string name, Global.PROP_TYPE type) {
      Name = name;
      Type = type;
    }
   
  }
}

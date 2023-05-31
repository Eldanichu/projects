using System;

namespace godotcsharpgame.Database.Attribute {
  [AttributeUsage(AttributeTargets.Property)]
  public class PropertyAttribute : System.Attribute {
    public string Name { get; }
    public PropertyAttribute(string name) {
      Name = name;
    }
  }
}

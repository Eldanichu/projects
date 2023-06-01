using System;

namespace godotcsharpgame.Database.Attribute {
  [AttributeUsage(AttributeTargets.Property)]
  public class PropertyAttribute : System.Attribute {
    public PropertyAttribute(string name) {
      Name = name;
    }
    public string Name { get; }
  }
}

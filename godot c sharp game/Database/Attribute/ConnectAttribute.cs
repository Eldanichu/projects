using System;

[AttributeUsage(AttributeTargets.Method)]
public class ConnectAttribute : Attribute {

  public ConnectAttribute(string dbName) {
    DBName = dbName;
  }
  public string DBName { get; }
}

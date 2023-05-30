  using System;

  [AttributeUsage(AttributeTargets.Method)]
  public class ConnectAttribute : Attribute {
    public string DBName { get; }

    public ConnectAttribute(string dbName) {
      DBName = dbName;
    }
  }


using System;
using System.Reflection;
using Godot;
using godotcsharpgame.Script.Util;
using SQLite;

public class DBConnection<T> : IDisposable {
  public SQLiteConnection connection { get; }
  private Type _type;

  public DBConnection() {
    _type = typeof(T);
    var _ready = _type.GetMethod("_Ready");
    if (null == _ready) {
      throw new Exception("DBConnect Attribute is not set.");
    }
    
    var attr = _ready.GetCustomAttribute<ConnectAttribute>();
    var db_path = StringUtil.PDir($"\\Database\\{attr.DBName}.db");
    connection = new SQLiteConnection(db_path);
  }

  public void Dispose() {
    connection.Close();
  }
}

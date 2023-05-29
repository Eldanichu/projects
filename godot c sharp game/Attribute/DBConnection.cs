using System;
using godotcsharpgame.Script.Util;
using SQLite;

public class DBConnection : IDisposable {
  public SQLiteConnection connection { get; }

  public DBConnection(string dbName = "Eldanado") {
    var db_path = StringUtil.PDir($"\\Database\\{dbName}.db");
    connection = new SQLiteConnection(db_path);
  }

  public void Dispose() {
    connection.Close();
  }
}

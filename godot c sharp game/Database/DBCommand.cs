using System;
using Godot;
using godotcsharpgame;
using SQLite;

public class DBCommand {

  private readonly SceneTree _tree;
  private Type _type;
  public SQLiteConnection Conn;


  public DBCommand(SceneTree tree) {
    _tree = tree;
    GetConnection();
  }

  private void GetConnection() {
    var main = _tree.Root.GetNode<Main>("main");
    Conn = main.Connection;
  }
}

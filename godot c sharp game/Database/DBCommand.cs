using System;
using Godot;
using SQLite;

public class DBCommand<T> where T : new() {

  private readonly SceneTree _tree;
  private Type _type;
  public SQLiteConnection Conn;


  public DBCommand(SceneTree tree) {
    _tree = tree;
    _type = typeof(T);
    GetConnection();
  }

  private void GetConnection() {
    var main = (Main)_tree.Root.GetNode("main");
    Conn = main.Connection;
  }
}

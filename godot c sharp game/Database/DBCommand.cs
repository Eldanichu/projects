using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using Godot;
using godotcsharpgame.Script.Util;
using SQLite;

public class DBCommand<T> where T : new() {
  
  private SceneTree _tree;
  public SQLiteConnection conn;
  private Type _type;
  

  public DBCommand(SceneTree tree) {
    _tree = tree;
    _type = typeof(T); 
    GetConnection();
  }

  private void GetConnection() {
    var main = (Main)_tree.Root.GetNode("main");
    conn = main.connection;
  }
}

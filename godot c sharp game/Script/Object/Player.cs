using System;
using Godot;
using Godot.Collections;
using godotcsharpgame.Script.Util;
using Array = Godot.Collections.Array;

public class Player : Node2D {
  public override void _Ready() {
    var ItemArray = new Array();
    using (var db = new DBConnection()) {
      var items = db.connection.Query<Item>($"select * from Item");
      foreach (var item in items) {
        ItemArray.Add(item.NAME);
      }
    }
    
    L.t($"item-> {ItemArray}");
 
    // var item = new Items() {
    //   _uid = StringUtil.GetId(),
    //   ID = "00346",
    //   NAME = "红瓶(小)"
    // };
    // cc.Insert(item);
    
  }
  
}

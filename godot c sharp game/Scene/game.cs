using Godot;
using System;
using Godot.Collections;
using godotcsharpgame.Script.Object.Player;
using godotcsharpgame.Script.Util;

public class game : Node2D {
    [Export] public PackedScene PlayerScene;
    
    public override void _Ready()
    {
        if (PlayerScene == null) {
            throw new Exception("PlayerScene's not set yet;");
        }
        
        var _OnCreatePlayer = new GlobalGameEvent() {
            Tree = GetTree(),
            EventName = "OnGameCreatePlayer"
        };
        _OnCreatePlayer.Connect(this, "OnGameCreatePlayer");
    }
    
    public void OnGameCreatePlayer(Dictionary form) {
        L.t($"Creating Player Info -> {form}");
        var menu = TNode.GetNode<CanvasLayer>(GetTree(),"%Menu");
        menu.Visible = false;
        var playerScene = (PlayerNode)PlayerScene.Instance();
        playerScene.Create(form);
        AddChild(playerScene);
    }

//  public override void _Process(float delta)
//  {
//      
//  }
}

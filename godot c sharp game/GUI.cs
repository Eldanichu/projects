using Godot;
using Godot.Collections;
using godotcsharpgame.Script.Object.Player.Node;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame {
  public class GUI : CanvasLayer {
    private Tween _tween;
    private MarginContainer _uiContainer;
    public override void _Ready() {
      _tween = new Tween();
      AddChild(_tween);
      _uiContainer = GetNode<MarginContainer>("%ui_control");
      Connect("visibility_changed", this, "OnVisChanged");
    
      var _OnCreatePlayer = new GlobalGameEvent() {
        Tree = GetTree(),
        EventName = "OnCreatePlayer"
      };
      _OnCreatePlayer.Connect(this, "OnCreatePlayer");
    }

    public void OnCreatePlayer(Dictionary form) {
      L.t($"Creating Player Info -> {form}");
      var menu = TNode.GetNode<CanvasLayer>(GetTree(),"%Menu");
      menu.Visible = false;
      var _player = TNode.GetNode<PlayerNode>(GetTree(),"Player");
      _player.Create((Global.CLASS_TYPE)form["ClassType"]);
      var _game = TNode.GetNode<Node2D>(GetTree(), "%game");
      _game.Visible = true;

      Visible = true;
    }
    public void OnVisChanged() {
      var value = Visible ? 1f : 0f;
      var uiContainerModulate = _uiContainer.Modulate;
      uiContainerModulate.a = 0;
      _tween.InterpolateProperty(
              _uiContainer, 
              "modulate:a", 
              uiContainerModulate.a,
              value, 
              0.5f, 
              Tween.TransitionType.Cubic, 
              Tween.EaseType.InOut
      );
      _tween.Start();
    }
  }
}

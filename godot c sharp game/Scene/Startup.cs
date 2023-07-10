using Godot;
using System;
using Godot.Collections;
using godotcsharpgame.Script.Util;
using Array = Godot.Collections.Array;

public class Startup : Control {
  private VBoxContainer _menu;
  private Control _createPlayer;

  public override void _Ready() {
    _menu = GetNode<VBoxContainer>("%menu");
    _createPlayer = GetNode<Control>("%CreatePlayer");
    var _menu_buttons = _menu.GetChildren();
    foreach (Button button in _menu_buttons) {
      button.Connect("pressed", this, "_OnMenuButtonClick", new Array {button.Name});
    }
  }

  public override void _Process(float delta) {

  }

  public void _OnMenuButtonClick(string button_name) {
    L.t($"{button_name}");
    switch (button_name) {
      case "start":
        _createPlayer.Visible = true;
        break;
      default:
        break;
    }
  }
}

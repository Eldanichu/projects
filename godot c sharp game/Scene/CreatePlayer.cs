using Godot;
using Godot.Collections;
using godotcsharpgame.Script.Util;

public class CreatePlayer : Control {

  private Button _create;
  private LineEdit _name;
  private Button _class;
  
  public override void _Ready() {
    _create = GetNode<Button>("%create");
    _name = GetNode<LineEdit>("%t_name");
    _class = GetNode<Button>("%tao");
    _create.Connect("button_up", this, "_OnCreate");
  }

  public void _OnCreate() {
    L.t("button_up");
    var _classType = _class.Group.GetPressedButton();

    var _event = new GlobalGameEvent() {
      Tree = GetTree(),
      EventName = "OnCreatePlayer"
    };
    var form = new Dictionary<string, string>() {
      {"ClassType", _classType.Name},
      {"Name", _name.Text}
    };
    _event.Emit(form);

    Visible = false;
  }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}

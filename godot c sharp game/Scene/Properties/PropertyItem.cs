using Godot;
using System;

public class PropertyItem : HBoxContainer {

    public string key { set; get; }
    public string value { set; get; }
    
    private Label LableKey;
    private Label LableValue;
    public override void _Ready() {
        LableKey = GetNode<Label>("%key");
        LableValue = GetNode<Label>("%value");
    }

// Called every frame. 'delta' is the elapsed time since the previous frame.
  public override void _Process(float delta) {
      LableKey.Text = key;
      LableValue.Text = value;
  }
}

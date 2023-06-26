using Godot;
using System;

public partial class StatBar : TextureProgressBar {

  private Label _label;
  private Tween t;
  public double dMax { set; get; }
  public double dMin { set; get; }

  public override async void _Ready() {
    _label = GetNode<Label>("%label");
    dMax = 10;
    MaxValue = 100f;
    TweenProgress();
  }

  public override void _Process(double delta) {

  }

  public override void _Input(InputEvent @event) {
    if (@event is InputEventMouse mb) {
      if (mb.ButtonMask == MouseButtonMask.Left) {
        dMax += 10;
        TweenProgress();
        Console.WriteLine(dMax);
      }
    }
  }

  private void TweenProgress() {
    t = CreateTween().BindNode(this).SetTrans(Tween.TransitionType.Cubic);
    var value = Mathf.Max(1, dMax);
    t.TweenProperty(this, "value", value, 2).From(Value);
  }
}

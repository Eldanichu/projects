using Godot;
using System;
using System.Collections.Generic;
using godotcsharpgame.Script.Util;
using Array = Godot.Collections.Array;

public class DamageNumber : Position2D {
  [Export]
  public Curve CurveX;
  [Export]
  public Curve CurveY;
  
  public float value { set; get; }
  
  private float Length;
  private Random rnd;
  private List<float> Dirs = new List<float>() {-1, 1, 0.1f, 0.5f, 0.7f};
  private float dir;
  private Label _label;
  
  public override void _Ready() {
    rnd = new Random();
    _label = GetNode<Label>("%value");
    _label.Text = $"{rnd.R(1, 100)}";
    // _label.Text = $"{value}";
    _label.Set("custom_colors/font_color", Colors.White);
    RandomDirections();
    DisappearTween();
  }
  private void RandomDirections() {
    rnd = new Random();
    var i = rnd.R(0, Dirs.Count - 1);
    dir = Dirs[i];
  }
  private void DisappearTween() {
    var t = new Tween();
    AddChild(t);
    t.InterpolateProperty(_label,
            "modulate:a",
            _label.Modulate.a,
            0,
            1.05f);
    t.Start();
  }

  public override void _Process(float delta) {
    if (Length >= 1) {
      QueueFree();
      return;
    }
    Length += 0.008f;
    Position += new Vector2(CurveX.Interpolate(Length) * (dir * 1.44f), CurveY.Interpolate(Length) * -1f * 2.7f);
  }
}

using Godot;
using System;
using godotcsharpgame.Script.Util;

public class TextureProgressTween : TextureProgress {
  private Tween _t;
  private float _value0;
  private float _value1;
  private float _valueP;

  [Export]
  public float Value0 {
    set { _value0 = value; }
    get { return _value0; }
  }

  [Export]
  public float Value1 {
    set { _value1 = Mathf.Max(1, value); }
    get { return _value1; }
  }

  [Export]
  public float Duration { set; get; } = 0.3f;

  public override void _Ready() {
    _t = new Tween();
    AddChild(_t);
    MaxValue = 100;
  }

  public override void _PhysicsProcess(float delta) {
    StartTween();
  }

  private void StartTween() {
    if (!IsInsideTree() || _t == null) {
      return;
    }
    if (_t.IsActive()) {
      return;
    }
    MaxValue = 100;
    var p = _value0 / _value1 * 100;
    _valueP = Mathf.Max(0, p);
    TweenProgressValue();
  }

  private void TweenProgressValue() {
    _t.InterpolateProperty(this,
            "value",
            Value,
            _valueP,
            Duration,
            Tween.TransitionType.Cubic
    );
    _t.Start();
  }
}

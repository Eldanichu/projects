using Godot;
using System;
using GMir4.Empty.Scripts.ValueChanged;

public partial class MainScene : Node2D
{
  public override void _Ready() {
    BaseValue bv = new();
    bv.OnValueChangedEvent += ValueChanged;
    bv.Value = 10;
    bv.Value = 20;
  }
  public void ValueChanged(int ov, int nv) {
    Console.WriteLine($"old value:{ov}, new value {nv}");
  }
}

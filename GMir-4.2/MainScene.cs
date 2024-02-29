using Godot;
using System;
using GMir4.Empty.CSScript.Impl;
using GMir4.Empty.Scripts.ValueChanged;

public partial class MainScene : Node2D
{
  public override void _Ready() {
    var actorProps = new ActorProperties();
    var actor = new Actor(actorProps);
    var _b = actor.GetBase();
    _b.hp = -10;
    Console.WriteLine(_b.hp);
  }
}

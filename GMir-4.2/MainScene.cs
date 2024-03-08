using Godot;
using System;
using GMir4.Empty.CSScript.Impl;
using GMir4.Empty.Scripts.ValueChanged;
using NSBaseProperties;

public partial class MainScene : Node2D
{
  public override void _Ready() {
	var actorProps = new ActorProperties();
	var actor = new Actor(actorProps);
	
	var actorBase = actor.BaseProperties;
	actorBase.hp_max = 45;
	actorBase.hp = 32;
	Console.WriteLine(actorBase.hp_max);
	Console.WriteLine(actorProps.Percentage(actorBase.hp,actorBase.hp_max));
  }
}

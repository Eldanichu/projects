using Godot;
using System;
using godotcsharpgame.Script.Object.Damage;
using Array = Godot.Collections.Array;

public class test_main : Control {

  private RichTextLabel logger;
  private Button btnGetPower;

  public override void _Ready() {
    logger = GetNode<RichTextLabel>("%logger");
    logger.Clear();
    logger.AppendBbcode($"[fill]******** Logger ********[/fill]\n");
    btnGetPower = GetNode<Button>("%GetPower");
    btnGetPower.Connect("pressed", this, "btnGetPowerPressed");
  }

  public void btnGetPowerPressed() {
    var dmg = new DamageObject() {
      dMax = 50,
      dMin = 12
    };
    dmg.GetPower();
    logger.AppendBbcode($"made dmg ->{dmg.Power} - is critical? {dmg.IsCriticalPower} \n");
  }
}

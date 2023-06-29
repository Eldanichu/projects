using Godot;
using System;
using godotcsharpgame.Script.Object.Damage;
using godotcsharpgame.Script.Object.Properties;
using godotcsharpgame.Script.Util;
using Array = Godot.Collections.Array;

public class test_main : Control {

  private RichTextLabel logger;
  private MenuButton _menuButton;
  
  private Button btnGetPower;
  private Button btnLevelUp;

  private PlayerObject PlayerObject;
  private string currentClass;

  public override void _Ready() {
    _menuButton = GetNode<MenuButton>("%create_player");
    _menuButton.GetPopup().Connect("id_pressed", this, "btnMenuPressed");
    logger = GetNode<RichTextLabel>("%logger");
    logger.Clear();
    logger.AppendBbcode($"[fill]******** Logger ********[/fill]\n");
    btnGetPower = GetNode<Button>("%GetPower");
    btnGetPower.Connect("pressed", this, "btnGetPowerPressed");
    
    btnLevelUp = GetNode<Button>("%level_up");
    btnLevelUp.Connect("pressed", this, "btnLevelUpPressed");
  }

  public void btnGetPowerPressed() {
    var dmg = new DamageObject(PlayerObject.props);
    dmg.GetPower();
    logger.AppendBbcode($"made dmg ->{dmg.Power} - is critical? {dmg.IsCriticalPower} \n");
  }
  
  public void btnLevelUpPressed() {
    if (PlayerObject == null) {
      logger.AppendBbcode($"create a class first. \n");
      return;
    }
    PlayerObject.LevelUp();
    PlayerObject.PlayerClass.Calculate();
    var p = PlayerObject.props;
    PrintProps(currentClass, p);
  }

  public void btnMenuPressed(int id) {
    var pop = _menuButton.GetPopup();
    var item = pop.GetItemId(id);
    var name = pop.GetItemText(id);
    PlayerObject = new PlayerObject((Global.CLASS_TYPE)item);
    PlayerObject.PlayerClass.Calculate();
    logger.AppendBbcode($"{name} class is being created. \n");
    var p = PlayerObject.props;
    currentClass = name;
    PrintProps(currentClass, p);
    L.t($"{item}");
  }

  private void PrintProps(string name, BaseProperty property) {
    logger.AppendBbcode($"{name} class is level up. \n");
    if (property is PlayerProperties p) {
      logger.AppendBbcode($@"
      [table=2]
        [cell] Lv [/cell] [cell]{p.Level}[/cell]
        [cell] hp [/cell] [cell]{p.Hp1}[/cell]
        [cell] mp [/cell] [cell]{p.Mp1}[/cell]
        [cell] ac [/cell] [cell]{p.Ac0} - {p.Ac1}[/cell]
        [cell] mac [/cell] [cell]{p.Mac0} - {p.Mac1}[/cell]
        [cell] dc [/cell] [cell]{p.Dc0} - {p.Dc1}[/cell]
        [cell] mc [/cell] [cell]{p.Mc0} - {p.Mc1}[/cell]
        [cell] sc [/cell] [cell]{p.Sc0} - {p.Sc1}[/cell]
      [/table]
");
    }
  }
}

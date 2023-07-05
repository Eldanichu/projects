using Godot;
using System.Collections.Generic;
using godotcsharpgame.Script.Object.Damage;
using godotcsharpgame.Script.Object.Properties;
using godotcsharpgame.Script.Util;

public class test_main : Control {

  private RichTextLabel logger;
  private MenuButton _menuButton;

  private Button btnGetPower;
  private Button btnLevelUp;

  private PlayerObject PlayerObject;
  private string currentClass;

  private Property UProperty;

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

    UProperty = GetNode<Property>("%Property");
    // _progressTween = GetNode<TextureProgressTween>("%tprg");
    // var tick = new Tick(0);
    // tick.OnTick += (int i) => {
    //   if (PlayerObject == null) {
    //     return;
    //   }
    //   PlayerObject.GiveHp(-1);
    //   updateStats();
    // };
    // AddChild(tick);
    // tick.Start();
  }

  private void updateStats() {
    var p = PlayerObject.props;

  }

  private void sortArray() {
    var arr = new List<int>() {
      56, 3, 4, 5
    };
    arr.Sort((x, y) => x.CompareTo(y));
    foreach (var i in arr) {
      L.t($"{i}");
    }
  }

  public void btnGetPowerPressed() {
    if (PlayerObject == null) {
      return;
    }
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
    p.Hp0 = p.Hp1;
    L.t($"{item}");
  }

  private void PrintProps(string name, BaseProperty property) {
    logger.AppendBbcode($"{name} class is level up. \n");


    if (property is PlayerProperties p) {
      var properties = new Dictionary<string, string>() {
        {"Level", $"{p.Level}"},
        {"Hp", $"{p.Hp1}"},
        {"Mp", $"{p.Mp1}"},
        {"Ac", $"{p.Ac0} - {p.Ac1}"},
        {"Mac", $"{p.Mac0} - {p.Mac1}"},
        {"Dc", $"{p.Dc0} - {p.Dc1}"},
        {"Sc", $"{p.Sc0} - {p.Sc1}"},
        {"Mc", $"{p.Mc0} - {p.Mc1}"}

      };
      UProperty.Properties = properties;
//       logger.AppendBbcode($@"
//       [table=2]
//         [cell] Lv [/cell] [cell]{p.Level}[/cell]
//         [cell] hp [/cell] [cell]{p.Hp1}[/cell]
//         [cell] mp [/cell] [cell]{p.Mp1}[/cell]
//         [cell] ac [/cell] [cell]{p.Ac0} - {p.Ac1}[/cell]
//         [cell] mac [/cell] [cell]{p.Mac0} - {p.Mac1}[/cell]
//         [cell] dc [/cell] [cell]{p.Dc0} - {p.Dc1}[/cell]
//         [cell] mc [/cell] [cell]{p.Mc0} - {p.Mc1}[/cell]
//         [cell] sc [/cell] [cell]{p.Sc0} - {p.Sc1}[/cell]
//       [/table]
// ");
    }
  }
}

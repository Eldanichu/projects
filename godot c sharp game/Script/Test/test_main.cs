using System;
using Godot;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CsvHelper;
using godotcsharpgame.Script.Object.Damage;
using godotcsharpgame.Script.Object.Properties;
using godotcsharpgame.Script.Test;
using godotcsharpgame.Script.Util;

public class test_main : Control {

  private RichTextLabel logger;
  private MenuButton _menuButton;

  private Button btnGetPower;
  private Button btnLevelUp;

  private PlayerObject PlayerObject;
  private string currentClass;

  private Property UProperty;

  private Button ImportItems;
  private TextureProgressTween ImportProgress;
  private FileDialog fileDialog;

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
    ImportItems = GetNode<Button>("%import_items");
    fileDialog = GetNode<FileDialog>("%file");
    ImportProgress = GetNode<TextureProgressTween>("%import_prog");

    ImportItems.Connect("pressed", this, "ImportItemsPressed");
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

  public void ImportItemsPressed() {
    fileDialog.Visible = true;
    fileDialog.Connect("file_selected", this, "OnFileSelected");
    ImportProgress.Value0 = 0;
  }

  public void OnFileSelected(string path) {
    fileDialog.Visible = false;
    if (string.IsNullOrEmpty(path)) {
      throw new Exception("Selected path is empty");
    }

    var p = new Progress<ImportProgress>();
    p.ProgressChanged += ImportProgressEvent;
    Importer(path, p);
  }

  private void ImportProgressEvent(object sender, ImportProgress e) {
    ImportProgress.Value0 = e.Progress;
    L.t($"current item -> {e.CurrentItem}");
  }

  public void Importer(string path, IProgress<ImportProgress> progress) {
    var importProgress = new ImportProgress();
    var com = new DBCommand(GetTree());
    var conn = com.Conn;

    var list = conn.Query<GameItem>($"select _uid from Item");
    ImportProgress.Value1 = list.Count;
    Task.Run(() => {
      using (var reader = new StreamReader(path, Encoding.UTF8)) {
        using (var csv = new CsvReader(reader, CultureInfo.InvariantCulture)) {
          var records = csv.GetRecords<StdItems>();
          foreach (var @record in records) {
            var dict = new Dictionary<string, float>() {
              {"AC0", float.Parse(@record.AC0)},
              {"AC1", float.Parse(@record.AC1)},

              {"MAC0", float.Parse(@record.MAC0)},
              {"MAC1", float.Parse(@record.MAC1)},

              {"DC0", float.Parse(@record.DC0)},
              {"DC1", float.Parse(@record.DC1)},

              {"MC0", float.Parse(@record.MC0)},
              {"MC1", float.Parse(@record.MC1)},

              {"SC0", float.Parse(@record.SC0)},
              {"SC1", float.Parse(@record.SC1)},
            };
            var json = JSON.Print(dict);
            conn.Execute($"update Item set ICON = '{@record.Looks}',PROPS = '{json}' where NAME = '{@record.Name}'");
            importProgress.Progress++;
            importProgress.CurrentItem = json;
            progress.Report(importProgress);
            // var list = conn.Query<GameItem>($"select _uid,NAME from Item where NAME = '{@record.Name}'");
            // if (list.Count > 1) {
            //   var item = list[0];
            //   conn.Execute($"delete from Item where _uid = '{item._uid}'");
            // }
            // conn.Execute($"INSERT INTO Item VALUES ('{StringUtil.GetId()}','','{@record.Name}','','','','')");
          }
        }
      }
    });
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

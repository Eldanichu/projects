using SQLite;

namespace godotcsharpgame.Script.Test {
  [Table("Item")]
  public class GameItem {
    [Column("_uid")] public string _uid { set; get; }
    [Column("ID")] public string ID { set; get; }
    [Column("NAME")] public string NAME { set; get; }
    [Column("STACKABLE")] public bool STACKABLE { set; get; }
    [Column("ICON")] public string ICON { set; get; }
    [Column("EFFECT_ID")] public string EFFECT_ID { set; get; }
    [Column("PROPS")] public string PROPS { set; get; }

  }
}

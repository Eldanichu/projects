using SQLite;

[Table("Item")]
public class Item {
  [Column("_uid")] public string _uid { set; get; }
  [PrimaryKey] [Column("ID")] [Indexed] public string ID { set; get; }
  [Column("NAME")] public string NAME { set; get; }
  [Column("STACKABLE")] public string STACKABLE { set; get; }
  [Column("EFFECT_ID")] public string EFFECT_ID { set; get; }
}

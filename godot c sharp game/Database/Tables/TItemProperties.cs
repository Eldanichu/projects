using SQLite;

[Table("ItemProperties")]
public class TItemProperties {
  [PrimaryKey][Column("IPID")]
  public string ID { get; set; }
}

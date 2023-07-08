using CsvHelper.Configuration.Attributes;

namespace godotcsharpgame.Script.Test {
  [Delimiter(",")]
  public class StdItems {
    [Name("Name")]
    public string Name { get; set; }
    
    [Name("StdMode")]
    public string StdMode { get; set; }
    
    [Name("Looks")]
    public string Looks { get; set; }
    
    [Name("AC")]
    public string AC0 { get; set; }
    [Name("AC2")]
    public string AC1 { get; set; }
    
    [Name("DC")]
    public string DC0 { get; set; }
    [Name("DC2")]
    public string DC1 { get; set; }
    
    [Name("SC")]
    public string SC0 { get; set; }
    [Name("SC2")]
    public string SC1 { get; set; }

    [Name("MC")]
    public string MC0 { get; set; }
    [Name("MC2")]
    public string MC1 { get; set; }
    
    [Name("MAC")]
    public string MAC0 { get; set; }
    [Name("MAC2")]
    public string MAC1 { get; set; }
  }
}

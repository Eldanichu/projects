namespace godotcsharpgame.Script.Object.Damage {
  public class DamageGenerator<TDamageType> : DamageObject 
          where TDamageType : DamageType, new() {
    public TDamageType damageType { set; get; }
    
    public DamageGenerator() {
      damageType = new TDamageType();
    }
    
  }
}

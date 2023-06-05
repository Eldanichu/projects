namespace godotcsharpgame.Script.Object.Player.Obj {
  public class PlayerGenerator<T> : PlayerObject where T : PlayerClass,new() {

    public PlayerGenerator() {
      PlayerClass = new T();
    }
  }
}

public class TaoClass<T> where T : PlayerClass, new() {
  
  public T classInstance;
  
  public TaoClass(PlayerObject player) {
    classInstance = new T() {
      classType = Global.CLASS_TYPE.tao
    };
    player.Props.ClassType = (int)classInstance.classType;
    classInstance.ApplyProperties(player);
  }


}

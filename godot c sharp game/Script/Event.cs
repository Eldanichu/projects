using Godot;
using Godot.Collections;


public class Event : Node {
  [Signal]
  public delegate void OnCreatePlayer(Dictionary form);
  
  
  #region Player
  [Signal]
  public delegate void PlayerAttack(Node n);

  #endregion
}

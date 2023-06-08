using Godot;
using Godot.Collections;


public class Event : Node {
  [Signal]
  public delegate void OnCreatePlayer(Dictionary form);
  
  [Signal]
  public delegate void OnPlayerMoving(Vector2[] movePath);
  #region Player
  [Signal]
  public delegate void PlayerAttack(Node n);

  #endregion
}

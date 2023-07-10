using Godot;
using Godot.Collections;
using godotcsharpgame.Scene;

namespace godotcsharpgame.Script {
  public class Event : Node {
    [Signal]
    public delegate void OnGameCreatePlayer(Dictionary playerModel);
  
    [Signal]
    public delegate void OnPlayerMoving(Vector2[] movePath);
    
    #region Player
    [Signal]
    public delegate void PlayerAttack(Node n);

    #endregion
  }
}

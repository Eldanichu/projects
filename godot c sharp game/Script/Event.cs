using Godot;

public class Event : Node {
  #region Player

  [Signal]
  public delegate void PlayerAttack(Node n);

  #endregion
}

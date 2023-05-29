using Godot;
using System;
using System.Diagnostics.Tracing;

public class Event : Node {
  #region Player
  
  [Signal]
  public delegate void PlayerAttack(Node n);
  
  #endregion
  
  
}

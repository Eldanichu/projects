using System;
using System.Collections.Generic;
using Godot;

public interface IPlayer {
  Node node { set; get; }
  List<Node> Targets { set; get; }
  PlayerProperties props { set; get; }
  List<String> Inventory { set; get; }
}

using Godot;
using godotcsharpgame.Script.Object.Properties;

namespace godotcsharpgame.Script.Interface.Player {
  public interface IPlayer {
    Node node { get; set; }
    PlayerProperties props { get; set; }
  }
}

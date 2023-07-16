using Godot;

namespace godotcsharpgame.Script.Interface {
  public interface IItem {
    Node Target { set; get; }
    void Use();
    void Equip();
  }
}

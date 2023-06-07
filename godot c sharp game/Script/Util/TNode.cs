using Godot;

namespace godotcsharpgame.Script.Util {
  public static class TNode {
    public static T GetNode<T>(SceneTree tree, string node_name) where T : class {
      var root = tree.Root;
      var main = root.GetNode("main");
      return main.GetNode<T>(node_name);
    }
  }
}

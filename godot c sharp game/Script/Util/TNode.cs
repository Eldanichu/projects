using Godot;

namespace godotcsharpgame.Script.Util {
  public static class TNode {
    public static T GetNode<T>(SceneTree tree, string node_name) where T : class {
      var root = tree.Root;
      var main = root.GetNodeOrNull("main");
      if (main == null) {
        return null;
      }

      var node = main.GetNodeOrNull<T>(node_name);
      if (node == null) {
        var gameNode = main.GetNode<Node2D>("%game");
        node = gameNode.GetNode<T>(node_name);
      }

      return node;
    }
  }
}

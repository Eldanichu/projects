using Godot;
using Godot.Collections;

// ReSharper disable once CheckNamespace
public class GlobalGameEvent {

  public SceneTree Tree { set; get; }
  public string EventName { set; get; }

  private Node GetNode() {
    var main = Tree.Root.GetNode("main");
    return main.GetNode("Event");
  }

  public void Emit(Object o) {
    GetNode().EmitSignal(EventName, o);
  }

  public Error Connect(Object targetNode, string method) {
    return GetNode().Connect(EventName, targetNode, method);
  }

  public Error Connect(Object targetNode, string method, Array binds) {
    return GetNode().Connect(EventName, targetNode, method, binds);
  }

  public Error Connect(Object targetNode, string method, Array binds, uint connectFlag) {
    return GetNode().Connect(EventName, targetNode, method, binds, connectFlag);
  }
}

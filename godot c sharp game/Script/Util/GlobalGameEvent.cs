using Godot;
using Godot.Collections;


namespace godotcsharpgame.Script.Util {
  public class GlobalGameEvent {

    public SceneTree Tree { set; get; }
    public string EventName { set; get; }

    private Node GetNode() {
      var events = TNode.GetNode<Node>(Tree,"%Event");
      return events;
    }

    public void Emit(Dictionary o) {
      GetNode().EmitSignal(EventName, o);
    }
    
    public void Emit(Godot.Object o) {
      GetNode().EmitSignal(EventName, o);
    }
    public Error Connect(Godot.Object targetNode, string method) {
      return GetNode().Connect(EventName, targetNode, method);
    }

    public Error Connect(Godot.Object targetNode, string method, Array binds) {
      return GetNode().Connect(EventName, targetNode, method, binds);
    }

    public Error Connect(Godot.Object targetNode, string method, Array binds, uint connectFlag) {
      return GetNode().Connect(EventName, targetNode, method, binds, connectFlag);
    }
  }
}

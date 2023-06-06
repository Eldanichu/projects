using Godot;
using godotcsharpgame.Script.Object.Monster.Base.Obj;

public abstract class BaseObject {
  public string Id;
  public string Name;
  public Node Object;
  public abstract bool IsTargetObject(PlayerObject target);
  public abstract bool IsTargetObject(MonsterObject target);
}

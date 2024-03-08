using NSBaseProperties;

namespace GMir4.Empty.CSScript.Impl;

public class Actor : IActor<IActorClass> {
  public IActorClass ActorClass { get; private set; }

  private readonly IActorProperties _actorProperties;
  
  public Actor(IActorProperties actorProperties) {
    _actorProperties = actorProperties;
  }

  public void ApplyActorClass(IActorClass actorClass) {
    ActorClass = actorClass;
    actorClass.Create();
  }
  public IBaseProperties BaseProperties => _actorProperties.GetBase();
  public IOtherProperties OtherProperties => _actorProperties.GetOther();
}

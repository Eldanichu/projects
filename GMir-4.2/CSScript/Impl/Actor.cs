using NSBaseProperties;

namespace GMir4.Empty.CSScript.Impl; 

public class Actor {
  
  private readonly IActorProperties _actorProperties;
  
  public Actor(IActorProperties actorProperties) {
    _actorProperties = actorProperties;
  }
  
  public IBaseProperties BaseProperties => _actorProperties.GetBase();
  public IOtherProperties OtherProperties => _actorProperties.GetOther();
}

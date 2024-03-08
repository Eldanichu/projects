namespace NSBaseProperties; 

public interface IActor<T> where T: IActorClass {
  void ApplyActorClass(T actorClass);
  IBaseProperties BaseProperties { get; }
  IOtherProperties OtherProperties { get; }
}

namespace NSBaseProperties; 

public interface IActorProperties : IBaseProperties, IOtherProperties {
  float Percentage(int pMin,int pMax);
  IBaseProperties GetBase();
  IOtherProperties GetOther();
}

namespace GMir4.Empty.Scripts.ValueChanged; 

public interface IBaseValue {
  int Value { get; set; }
  void Changed(int oldValue, int newValue);
}

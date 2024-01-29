namespace GMir4.Empty.Scripts.ValueChanged;

public class BaseValue : IBaseValue {
  private int _value;

  public int Value {
    get => _value;
    set {
      Changed(_value,value);
      _value = value;
    }
  }

  public delegate void OnValueChanged(int oldValue, int newValue);
  public event OnValueChanged OnValueChangedEvent;

  public void Changed(int oldValue, int newValue) {
    OnValueChangedEvent?.Invoke(oldValue, newValue);
  }
}

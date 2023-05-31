public interface IBuffEvent {
  void OnChange(BuffEvent.BUFF_STATE state);
  void OnAdd();
  void OnRemove();
  void OnAffect();
  void OnFinish();
}

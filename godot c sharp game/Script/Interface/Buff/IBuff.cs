public interface IBuff {
  string BuffName { set; get; }
  Tick tick { set; get; }
  void Effect(int time);
}

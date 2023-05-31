public interface IBuff {
  string BuffName { set; get; }
  Tick tick { set; get; }
  BaseObject Owner { set; get; }
  void Effect(int time);
}

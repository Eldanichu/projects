public interface IBaseBuff : IBuff {
  int TickTimes { set; get; }
  void Add();
  void Remove();
}

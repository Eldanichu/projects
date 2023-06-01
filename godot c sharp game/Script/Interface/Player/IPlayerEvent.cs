using System.Collections.Generic;

public interface IPlayerEvent {
  void LevelUp();
  void GainExp(int exps);
  bool Dead();
  void GainItems(List<Item> items);
}

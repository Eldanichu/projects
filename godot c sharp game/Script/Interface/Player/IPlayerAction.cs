public interface IPlayerAction {
  void GiveItem(Item item);
  int TakeItem(string ItemId);
  void AddSkill(Skill skill);
  bool DeleteSkill(string skillId);
  void GiveExp(int value = 0);
  void GiveHp(int value = 0);
  void GiveMp(int value = 0);
}

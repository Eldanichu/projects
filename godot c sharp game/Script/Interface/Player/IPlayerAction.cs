public interface IPlayerAction {
  void GiveItem(Item item);
  int TakeItem(string ItemId);
  void AddSkill(Skill skill);
  bool DeleteSkill(string skillId);
}

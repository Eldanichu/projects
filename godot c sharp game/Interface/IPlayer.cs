public interface IPlayer : IPlayerProperties {
  bool Dead();
  void LevelUp();
  void Attack();
  void UseItem();
  void Spell();
  void TakeDamage();
}

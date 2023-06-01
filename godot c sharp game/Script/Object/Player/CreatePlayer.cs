public class CreatePlayer<TPlayerObject, TPlayerClass>
        where TPlayerObject : PlayerObject, new()
        where TPlayerClass : PlayerClass, new() {
  private TPlayerClass _playerClass { set; get; }
  public TPlayerObject Player { set; get; }

  public CreatePlayer() {
    Player = new TPlayerObject();
    _playerClass = new TPlayerClass();
    Apply();
  }

  private void Apply() {
    Player.props.ClassName = _playerClass.GetType().Name;
    Player.props.ClassType = (int)_playerClass.Type;
    Player.Skills = _playerClass.Skills;
    Player.props.Level = 1;
    Player.CalculateProperties();
  }
}

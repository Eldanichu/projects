public class CreatePlayer<TPlayerObject, TPlayerClass>
        where TPlayerObject : PlayerObject, new()
        where TPlayerClass : PlayerClass, new() {

  public CreatePlayer() {
    Player = new TPlayerObject();
    _playerClass = new TPlayerClass();
    Apply();
  }
  private TPlayerClass _playerClass { get; }
  public TPlayerObject Player { set; get; }

  private void Apply() {
    Player.props.ClassName = _playerClass.GetType().Name;
    Player.props.ClassType = (int)_playerClass.Type;
    Player.Skills = _playerClass.Skills;
    Player.props.Level = 1;
    Player.PlayerClass = _playerClass;
    Player.CalculateProperties();
  }
}

using Godot;

public interface IBaseSkill : ISkill, ISkillEvent {
  decimal Cooldown { set; get; }
  Timer Timer { set; get; }
  int MpReq { set; get; }
  void Cast();
}

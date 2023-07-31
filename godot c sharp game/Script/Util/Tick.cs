using Godot;

public class Tick : Node {
  public delegate void TimerAction(int count);

  public delegate void TimerProcess();
  private int _count;
  private bool _isPaused;

  public Tick(int amount = 1, float interval = 1) {
    Amount = amount;
    Timer = new Timer {
      WaitTime = interval,
      OneShot = true
    };
    Timer.Connect("timeout", this, "_OnTimeout");
    AddChild(Timer);
  }
  private Timer Timer { get; }
  public TimerAction OnTick { set; get; }
  private int Amount { get; }

  public override void _PhysicsProcess(float delta) {
    
  }

  public void Start() {
    Timer.Start();
    _isPaused = false;
  }

  public void Pause() {
    Timer.Stop();
    _isPaused = true;
  }

  public void Stop() {
    Timer.Stop();
  }

  public void _OnTimeout() {
    if (_isPaused) return;
    if (Amount == 0) {
      OnTick(-1);
      Timer.Start();
      return;
    }
    if (_count >= Amount) {
      Timer.Stop();
      QueueFree();
      return;
    }
    OnTick(_count + 1);
    Timer.Start();
    _count++;
  }
}

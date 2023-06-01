using Godot;

public class Tick : Node {
  public delegate void TimerAction(int count);
  private int _count;
  private bool _isPaused;

  public Tick(int amount = 1) {
    Amount = amount;
    Timer = new Timer {
      WaitTime = 1,
      OneShot = true
    };
    Timer.Connect("timeout", this, "_OnTimeout");
    AddChild(Timer);
  }
  private Timer Timer { get; }
  public TimerAction OnTick { set; get; }
  private int Amount { get; }

  public void Start() {
    Timer.Start();
    _isPaused = false;
  }

  public void Pause() {
    Timer.Stop();
    _isPaused = true;
  }

  public void _OnTimeout() {
    OnTick(_count + 1);
    if (_isPaused) return;
    if (_count >= Amount) {
      Timer.Stop();
      QueueFree();
      return;
    }
    ;
    Timer.Start();
    _count++;
  }
}

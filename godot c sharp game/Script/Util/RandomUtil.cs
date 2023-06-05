using System;
using Godot;

public class Random {
  private RandomNumberGenerator rnd;

  public int R(int min, int max) {
    int res;
    using (rnd = new RandomNumberGenerator()) {
      rnd.Randomize();
      res = rnd.RandiRange(min, max);
    }

    return res;
  }

  public float R(float min, float max) {
    float res;
    using (rnd = new RandomNumberGenerator()) {
      rnd.Randomize();
      res = rnd.RandfRange(min, max);
    }

    return res;
  }

  public uint I(int limit = 0) {
    uint res;
    using (rnd = new RandomNumberGenerator()) {
      rnd.Randomize();
      res = (uint)(limit > 0 ? rnd.Randi() % limit : rnd.Randi()) + 1;
    }

    return res;
  }
}

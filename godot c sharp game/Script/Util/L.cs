using System;

namespace godotcsharpgame.Script.Util {
  public class L {
    public static void t(string strs) {
      Console.WriteLine($"[INFO] - {strs}");
    }

    public static void d(string strs) {
      Console.WriteLine($"[DEBUG] - {strs}");
    }

    public static void e(string strs) {
      Console.WriteLine($"[ERROR] - {strs}");
    }
  }
}

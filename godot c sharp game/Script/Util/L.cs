using System;

namespace godotcsharpgame.Script.Util {
  public class L {
    static public void t(string strs) {
      Console.WriteLine($"[INFO] - {strs}");
    }
    
    static public void d(string strs) {
      Console.WriteLine($"[DEBUG] - {strs}");
    }
    
    static public void e(string strs) {
      Console.WriteLine($"[ERROR] - {strs}");
    }
  }
}

﻿using Godot;
using Environment = System.Environment;

namespace godotcsharpgame.Script.Util {
  public class StringUtil {
    public static string GetId(int length = 12) {
      var rnd = new RandomNumberGenerator();
      rnd.Randomize();
      var str = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890";
      var strLen = str.Length;
      var Id = "";
      for (var i = 0; i < length; i++) {
        var index = rnd.RandiRange(0, strLen - 1);
        var c = str.Substring(index, 1);
        Id += c;
      }

      return Id;
    }

    public static string PDir(string path) {
      var project_path = Environment.CurrentDirectory;
      var _path = $"{project_path}{path}";

      return _path;
    }
  }
}

using System;
using Godot;
using Godot.Collections;

public class BigNumber {

  private readonly Array<string> _alphabet = new Array<string> {
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w",
    "x", "y", "z"
  };

  private readonly Dictionary<string, string> _postFixes = new Dictionary<string, string> {
    {"0", ""},
    {"1", "k"},
    {"2", "m"},
    {"3", "b"},
    {"4", "t"},
    {"5", "a0"},
    {"6", "a1"},
    {"7", "a2"},
    {"8", "a3"},
    {"9", "a4"},
    {"10", "a5"},
    {"11", "a6"},
    {"12", "a7"},
    {"13", "a8"},
    {"14", "a9"},
    {"15", "b0"},
    {"16", "b1"},
    {"17", "b2"},
    {"18", "b3"},
    {"19", "b4"},
    {"20", "b5"},
    {"21", "b6"},
    {"22", "b7"},
    {"23", "b8"},
    {"24", "b9"},
    {"25", "c0"},
    {"26", "c1"},
    {"27", "c2"},
    {"28", "c3"},
    {"29", "c4"},
    {"30", "c5"},
    {"31", "c6"},
    {"32", "c7"},
    {"33", "c8"},
    {"34", "c9"},
    {"35", "d0"},
    {"36", "d1"},
    {"37", "d2"},
    {"38", "d3"},
    {"39", "d4"},
    {"40", "d5"},
    {"41", "d6"},
    {"42", "d7"},
    {"43", "d8"},
    {"44", "d9"},
    {"45", "e0"},
    {"46", "e1"},
    {"47", "e2"},
    {"48", "e3"},
    {"49", "e4"},
    {"50", "e5"},
    {"51", "e6"},
    {"52", "e7"},
    {"53", "e8"},
    {"54", "e9"},
    {"55", "f0"},
    {"56", "f1"},
    {"57", "f2"}
  };

  private int _exponent = 1;
  private float _mantissa;

  public BigNumber(string m, int e = 0) {
    _mantissa = float.Parse(m);
    _exponent = e;

    var scientific = m.Split("e");
    _mantissa = float.Parse(scientific[0]);
    if (scientific.Length > 1)
      _exponent = int.Parse(scientific[1]);
    else
      _exponent = 0;

    Calculate();
  }

  public string ToAA() {
    var target = Math.Floor(_exponent / 3f);
    var hundreds = 1;
    for (var i = 0; i < _exponent % 3; i++) hundreds *= 10;

    var prefix = _mantissa * hundreds;
    var postfix = _postFixes[target.ToString()];
    var result = "";
    var split = prefix.ToString().Split(".");
    if (target == 0)
      result = split[0];
    else
      result = $"{prefix}";

    return result + postfix;
  }

  private void Calculate() {
    if (_mantissa >= 10f || _mantissa < 1f) {
      var diff = (int)Math.Floor(Math.Log10(_mantissa));
      var div = Math.Pow(10f, diff);
      if (div > 0.0f) {
        _mantissa /= (float)div;
        _exponent += diff;
      }

      while (_exponent < 0) {
        _mantissa *= 0.1f;
        _exponent += 1;
      }

      while (_mantissa >= 10f) {
        _mantissa *= 0.1f;
        _exponent += 1;
      }

      if (_mantissa == 0f) _exponent = 0;
    }
  }
}

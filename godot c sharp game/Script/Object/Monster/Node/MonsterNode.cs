using System;
using Godot;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Monster.Node {
  public class MonsterNode : Godot.KinematicBody2D {

    private PathFinding _map;
    private Vector2[] MovePath;

    public bool IsMoving;
    public int pathIndex;
    public Vector2 TargetPosition { set; get; }
    public override void _Ready() {
      _map = TNode.GetNode<PathFinding>(GetTree(), "%map");
      var cell = _map.WorldToMap(Position);
      _map.TC.SetCellv(cell, 0);
    }
    public override void _PhysicsProcess(float delta) {
      if (MovePath == null || MovePath.Length <= 0) {
        return;
      }

      if (pathIndex < MovePath.Length && IsMoving) {
        var cell = MovePath[pathIndex];
        L.t($"last cell ->{cell}");
        // var cellType = _map.GetAroundCellsType(cell,4);
        _map.TC.SetCellv(cell, -1);
        var point = _map.GetWorldCellVector2(cell);
        var dist = Math.Floor(Position.DistanceTo(point));

        if (dist <= 1d) {
          pathIndex++;
          L.t($"{pathIndex}");
        }
        Position = Position.LinearInterpolate(point, 0.18f);
        if (pathIndex < MovePath.Length) {
          cell = MovePath[pathIndex];
          _map.TC.SetCellv(cell, 0);
        }
      }
      else {
        pathIndex = 0;
        IsMoving = false;
        MovePath = new Vector2[0];
      }

      if (!IsMoving) {
        Position = Position.LinearInterpolate(TargetPosition, 0.3f);
      }
    }
  }
}

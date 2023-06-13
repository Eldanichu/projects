using System;
using Godot;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Monster.Node {
  public class Monster : Godot.Node2D {

    private PathFinding _map;
    private Vector2[] MovePath;
    private Tween _tweenMove;
    private Tick moveTick;
    private Vector2 lastCell = Vector2.Zero;
    public float moveInterval = 3f;

    public override void _Ready() {
      SetupNode();
    }
    private void SetupNode() {
      _tweenMove = new Tween();
      AddChild(_tweenMove);
      moveTick = new Tick(0, moveInterval);
      AddChild(moveTick);
      _map = TNode.GetNode<PathFinding>(GetTree(), "%map");
      Reset();
      moveTick.OnTick += RandMovement;
      moveTick.Start();
    }

    public void RandMovement(int tick) {
      var nextDir = _map.GetRandomWalkableDir(_map.WorldToMap(Position));
      if (lastCell != Vector2.Zero) {
        // L.t($"{lastCell}");
        _map.TC.SetCellv(lastCell, (int)Global.TILE_TYPE.INVALID);
      }
      var cell = _map.WorldToMap(Position) + nextDir;
      var point = _map.GetWorldCellVector2(cell);
      _tweenMove.InterpolateProperty(this,
              "position",
              Position,
              point,
              0.1f,
              Tween.TransitionType.Cubic,
              Tween.EaseType.OutIn
      );
      _map.TC.SetCellv(cell, (int)Global.TILE_TYPE.MONSTER);
      lastCell = cell;
      _tweenMove.Start();
      moveTick.Start();
      // L.t($"move {tick} - path{_map.WorldToMap(Position) + nextDir}");
    }

    public override void _PhysicsProcess(float delta) {

    }

    private void Reset() {
      lastCell = _map.WorldToMap(Position);
      _map.TC.SetCellv(lastCell, (int)Global.TILE_TYPE.MONSTER);
    }

  }
}

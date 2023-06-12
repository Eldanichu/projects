using System;
using Godot;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Monster.Node {
  public class MonsterNode : Godot.Sprite {

	private PathFinding _map;
	private Vector2[] MovePath;
	private Tween _tweenMove;
	private Vector2 lastCell = Vector2.Zero;

	public int MoveIndex;
	public float moveInterval = 0.2f;
	public float elapseTime;
	public override void _Ready() {
	  SetupNode();
	  var spriteT = GetTransform();
	  var extend = GetRect().Size * spriteT.Scale;
	  var size = extend.x;

	  var polyline = new Vector2[4];
	  polyline[0] = new Vector2(extend.x - size * 2, extend.y - size * 2);
	  polyline[1] = new Vector2(extend.x + size, extend.y - size * 2);
	  polyline[2] = new Vector2(extend.x + size, extend.y + size);
	  polyline[3] = new Vector2(extend.x - size * 2, extend.y + size);

	  var poly = new Polygon2D() {
		Polygon = polyline,
		Color = Colors.Gray
	  };

	  AddChild(poly);
	}

	public override void _PhysicsProcess(float delta) {
	  MoveAlongPath(delta);
	}

	private void SetupNode() {
	  _tweenMove = new Tween();
	  _tweenMove.Connect("tween_all_completed", this, "_onStepFinished");
	  AddChild(_tweenMove);
	  _map = TNode.GetNode<PathFinding>(GetTree(), "%map");

	  lastCell = _map.WorldToMap(Position);
	  _map.TC.SetCellv(lastCell, (int)Global.TILE_TYPE.PLAYER);
	}

	private void MoveAlongPath(float delta) {
	  if (MovePath == null || MovePath.Length <= 0) {
		return;
	  }
	  if (elapseTime < moveInterval) {
		elapseTime += delta;
		return;
	  }
	  if (MoveIndex >= MovePath.Length) {
		return;
	  }
	  var movePathLength = (MoveIndex + 1 >= MovePath.Length) ? MovePath.Length - 1 : MoveIndex + 1;
	  var nextCell = MovePath[movePathLength];
	  var nextPoint = _map.GetWorldCellVector2(nextCell);
	  if (_map.CellHasObjectTC(nextPoint) || _map.CellHasObject(nextPoint)) {
		return;
	  }

	  // L.t($"start move");
	  if (lastCell != Vector2.Zero) {
		// L.t($"{lastCell}");
		_map.TC.SetCellv(lastCell, (int)Global.TILE_TYPE.INVALID);
	  }
	  var cell = MovePath[MoveIndex];
	  var point = _map.GetWorldCellVector2(cell);
	  _tweenMove.InterpolateProperty(this,
			  "position",
			  Position,
			  point,
			  moveInterval,
			  Tween.TransitionType.Cubic,
			  Tween.EaseType.OutIn
	  );
	  _map.TC.SetCellv(cell, (int)Global.TILE_TYPE.PLAYER);
	  lastCell = cell;
	  _tweenMove.Start();
	  elapseTime = 0;
	  MoveIndex++;
	}

  }
}

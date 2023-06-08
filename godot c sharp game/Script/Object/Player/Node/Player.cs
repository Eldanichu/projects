using System;
using System.Collections.Generic;
using Godot;
using godotcsharpgame.Script.Object.Damage;
using godotcsharpgame.Script.Object.Player.Obj;
using godotcsharpgame.Script.Util;
using Array = Godot.Collections.Array;

public class Player : KinematicBody2D {
  private ProgressBar expBar;
  private TextureProgress hpBar;
  private Label hpText;
  private TextureProgress mpBar;
  private Label mpText;
  private DamageObject _dmage;

  private TileMap _tileMap;
  private Vector2 mapSize = new Vector2(15, 7);
  private Vector2 _cellSize;
  private Vector2[] MovePath;
  private Array connections = new Array();
  private bool moving;
  private AStar2D _aStar;
  private int pathIndex;

  public Vector2 TargetPosition;
  public PlayerProperties props;
  public PlayerObject PlayerObject { set; get; }

  public override void _Ready() {
	_tileMap = TNode.GetNode<TileMap>(GetTree(), "%map");
	_cellSize = _tileMap.CellSize * 0.5f;
	ResetPlayerPosition();
	_aStar = new AStar2D();
	var obs = GetObstacles(_tileMap);
	var walkableCells = GenerateWalkableCells(obs);
	ConnectWalkableCells(walkableCells);
	// _tileMap.SetCellv(mapPlayerPosition,99);

	// _aStar.AddPoint(0,Position);

	// foreach (Vector2 tile in tiles) {
	//   _aStar.AddPoint(pathIndex,tile);
	//   pathIndex++;
	// }
	// var randomPosition = (int)new Random().I(tiles.Count);
	// TargetPosition = _tileMap.MapToWorld((Vector2)tiles[randomPosition]) + _cellSize;
	// TargetPosition = Position;
	// Create();
	_OnReady();
	_PlayerEvent();

  }
  public override void _PhysicsProcess(float delta) {
	if (MovePath == null || MovePath.Length <= 0) {
	  return;
	}
	if (pathIndex < MovePath.Length && moving) {
	  var point = _tileMap.MapToWorld(MovePath[pathIndex]) + _cellSize;
	  var dist = Math.Floor(Position.DistanceTo(point));
	  var dir = Position.DirectionTo(point);
	  if (dist <= 1d) {
		pathIndex++;
	  }
	  Position = Position.LinearInterpolate(point, 0.2f);
	}
	else {
	  pathIndex = 0;
	  moving = false;
	}
	if (!moving) {
	  Position = Position.LinearInterpolate(TargetPosition, 0.3f);
	}
	// var point = _tileMap.MapToWorld(MovePath[pathIndex]);
	// // var dist = Math.Floor(Position.DistanceTo(point));
	// // if (dist <= 2) {
	// //   moving = false;
	// //   return;
	// // }
	// var dir = Position.DirectionTo(point);
	// Position += dir * delta * 550;
  }
  
  public override void _Process(float delta) {
	if (PlayerObject == null) return;

	props = PlayerObject.props;
	hpText.Text = $"{props.Hp0}/{props.Hp1}";
	mpText.Text = $"{props.Mp0}/{props.Mp1}";

	hpBar.Value = props.Hp0 / props.Hp1 * 100;
	mpBar.Value = props.Mp0 / props.Mp1 * 100;
	expBar.Value = props.Exp0 / props.Exp1 * 100;
  }

  public override void _Input(InputEvent @event) {
	// if (PlayerObject == null) {
	//   return;
	// }
	if (!(@event is InputEventMouseButton mb)) return;
	if (mb.ButtonIndex == 1 && mb.Pressed) {
	  var mousePosition = GetGlobalMousePosition();

	  if (IsValidCell(_tileMap, mousePosition) && pathIndex == 0) {
		moving = true;
		TargetPosition = MoveSnap(_tileMap, mousePosition);
		GetMovePath(mousePosition, Position);
	  }

	  // _dmage = new DamageObject() {
	  //   Props = PlayerObject.props,
	  //   PlayerClass = PlayerObject.PlayerClass
	  // };
	  // _dmage.GetPower();
	  // L.t($"{_dmage.Power} - {_dmage.IsCritical}");
	}
  }
  public override void _ExitTree() {
	base._ExitTree();
	QueueFree();
  }
  public void Create(Global.CLASS_TYPE classType) {
	switch (classType) {
	  case Global.CLASS_TYPE.tao:
		PlayerObject = new PlayerGenerator<TaoClass>();
		break;
	  case Global.CLASS_TYPE.warrior:
		PlayerObject = new PlayerGenerator<WarClass>();
		break;
	  case Global.CLASS_TYPE.wizard:
		PlayerObject = new PlayerGenerator<WizClass>();
		break;
	}
	PlayerObject.node = this;
	PlayerObject.LevelUp();
	var props = PlayerObject.GetProps(Global.PROP_TYPE.ATTACK);
	L.t($"{props}");
  }
  private void _OnReady() {
	var g = GetTree().Root.GetNodeOrNull("main");
	hpText = g.FindNode("hp").GetNode<Label>("text");
	hpBar = g.FindNode("hp").GetNode<TextureProgress>("pg");
	mpText = g.FindNode("mp").GetNode<Label>("text");
	mpBar = g.FindNode("mp").GetNode<TextureProgress>("pg");
	expBar = g.FindNode("exp").GetNode<ProgressBar>("pg");
  }
  private void _PlayerEvent() {
	// if (PlayerObject == null) {
	//   return;
	// }
	// PlayerObject.AbilityChanged += (state, amount) => {
	//   switch (state) {
	//     case Global.PLAYER_ABILITY.LEVEL:
	//       L.t("Level Up!");
	//       break;
	//   }
	// };
  }
  
   private Array GetObstacles(TileMap map) {
	var obTiles = map.GetUsedCellsById(9);
	foreach (var obTile in obTiles) {
	  var tileVec = (Vector2)obTile;
	  var index = GetPointIndex(tileVec);
	  _aStar.AddPoint(index, tileVec);
	}
	return obTiles;
  }

  private Array GenerateWalkableCells(Array obstacles) {
	var globalCells = _tileMap.GetUsedCells();
	var cells = new Array();
	foreach (Vector2 point in globalCells) {
	  if (obstacles.Contains(point)) {
		continue;
	  }
	  cells.Add(point);
	  var cellIndex = GetPointIndex(point);
	  _aStar.AddPoint(cellIndex, point);
	}
	return cells;
  }

  private void ConnectWalkableCells(Array points) {
	foreach (Vector2 point in points) {
	  var pointIndex = GetPointIndex(point);
	  var pointsRels = new Array() {
		{point + Vector2.Right},
		{point + Vector2.Left},
		{point + Vector2.Down},
		{point + Vector2.Up},
	  };
	  foreach (Vector2 pointRel in pointsRels) {
		var pointRelIndex = GetPointIndex(pointRel);
		if (IsOutSideMap(pointRel)) {
		  continue;
		}
		if (!_aStar.HasPoint(pointRelIndex)) {
		  continue;
		}
		_aStar.ConnectPoints(pointIndex, pointRelIndex, false);
		var line = new Array() {
		  {_aStar.GetPointPosition(pointIndex)},
		  {_aStar.GetPointPosition(pointRelIndex)}
		};
		connections.Add(line);
	  }
	}
  }

  private bool IsOutSideMap(Vector2 point) {
	return point.x < 0 || point.y < 0 || point.x > mapSize.x || point.y > mapSize.y;
  }

  private int GetPointIndex(Vector2 point) {
	return (int)Math.Floor(point.x + mapSize.x * point.y);
  }

  private void ResetPlayerPosition() {
	Position = MoveSnap(_tileMap, Position);
  }
  private Vector2 MoveSnap(TileMap map, Vector2 position) {
	var mapPosition = map.WorldToMap(position);
	return map.MapToWorld(mapPosition) + _cellSize;
  }
  private int GetNextCell(TileMap map, Vector2 origin, Vector2 targetCell) {
	var dir = Position.DirectionTo(targetCell);
	var local = map.WorldToMap(origin) + dir.Floor();
	var nextCellId = map.GetCellv(local);
	return nextCellId;
  }
  private bool IsValidCell(TileMap map, Vector2 position) {
	var mapPos = map.WorldToMap(position);
	var cellType = map.GetCellv(mapPos);
	L.t($"MouseClicked Cell Type->{cellType}");
	return cellType != -1 && cellType != 9;
  }

  private void GetMovePath(Vector2 mousePosition, Vector2 targetPosition) {
	var mouseMapPos = _tileMap.WorldToMap(mousePosition);
	var mouseCellId = GetPointIndex(mouseMapPos);

	var playerMapPos = _tileMap.WorldToMap(targetPosition);
	var playerCellId = GetPointIndex(playerMapPos);

	MovePath = _aStar.GetPointPath(playerCellId, mouseCellId);
	var _event = new GlobalGameEvent() {
	  Tree = GetTree(),
	  EventName = "OnPlayerMoving"
	};
	_event.Emit(MovePath);
  }

}


// var item = new Items() {
//   _uid = StringUtil.GetId(),
//   ID = "00346",
//   NAME = "红瓶(小)"
// };
// cc.Insert(item);

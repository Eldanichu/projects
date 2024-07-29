extends Node
class_name Spawner

@export
var gui:GUI


@onready var player_mamger = %player_mamger
@onready var monster_manger = %monster_manger

var player:Dictionary = {}
var monster:Dictionary = {}

func _ready():
	gui.visibility_changed.connect(game_state_changed)

func game_state_changed():
	if not gui.visible:
		return
	spawn_player()
	#spawn_monster()

func spawn_player():
	var _tscn:PackedScene =  ResourceLoader.load("res://Scene/player.tscn")
	var _scene = _tscn.instantiate() as PlayerNode
	var _name = "target"
	var _node = F.add_node_ex(player_mamger, _scene, _name) as PlayerNode
	
	player[_name] = _node

func spawn_monster():
	var mon_tscn:PackedScene =  ResourceLoader.load("res://Scene/monster.tscn")
	var mon_scene = mon_tscn.instantiate()
	var mon_name = "target"
	var mon_node = F.add_node_ex(monster_manger, mon_scene, mon_name) as MonNode

	monster[mon_name] = mon_node




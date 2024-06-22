extends Node
class_name Spawner

@export
var gui:GUI

@onready var player_mamger = %player_mamger
@onready var monster_manger = %monster_manger

var player:Dictionary = {
	"attack" : Callable()
}

var monster:Dictionary = {
	
}

func _ready():
	spawn_monster()
	bind_gui_events()
	
	
func bind_gui_events():
	if not gui:
		return
	gui.attack.pressed.connect(player.attack)


func spawn_monster():
	var mon_tscn:PackedScene =  ResourceLoader.load("res://Scene/monster.tscn")
	var mon_scene = mon_tscn.instantiate()
	var mon_name = "target"
	var mon_node = F.add_node_ex(monster_manger, mon_scene, mon_name) as MonNode

	monster[mon_name] = mon_node




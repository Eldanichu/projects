extends Node

const scene_start_path:String = "res://Scenes/start/start.tscn"

var start:PackedScene = preload(scene_start_path)

onready var splash = get_node("%splash")

func _ready() -> void:
	create_game_sence()

func create_game_sence():
	yield(splash,"splash_end")

	print_debug('creating game sence')

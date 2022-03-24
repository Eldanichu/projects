extends Node


var splash
const scene_start_path:String = "res://Scenes/start/start.tscn"
var start:PackedScene = preload(scene_start_path)

func _ready() -> void:
  splash = $splash
  yield(splash,"splash_end")
  create_game_sence()
  pass

func create_game_sence():
  get_tree().change_scene_to(start)
  Logger.debug('creating game sence')
  pass

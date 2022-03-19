extends Node


var splash
const scene_start_path:String = "res://Scenes/start/start.tscn"
var start:PackedScene

func _ready() -> void:
  splash = $splash
  yield(splash,"splash_end")
  start = preload(scene_start_path)
  create_game_sence()
  pass

func create_game_sence():
  Logger.debug('creating game sence')
  get_tree().change_scene(scene_start_path)
  pass

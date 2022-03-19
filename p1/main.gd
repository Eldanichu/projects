extends Node


var splash
var scene_start_path:String = "res://Scenes/start/start.tscn"
var start:PackedScene

func _ready() -> void:
  splash = $splash
  yield(splash,"splash_end")
  create_game_sence()
  pass

func create_game_sence():
  Logger.debug('creating game sence')
  start = load(scene_start_path)
  start.instance();
  get_tree().change_scene(scene_start_path)
  pass

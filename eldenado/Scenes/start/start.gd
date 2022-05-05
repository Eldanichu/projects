extends Control

onready var new_game_dialog = find_node('new_game')
onready var game_scene = preload("res://Scenes/game/game.tscn")

func _ready() -> void:
  new_game_dialog.visible = false
  pass

func _on_start_game_pressed() -> void:
  new_game_dialog.visible = true
  pass # Replace with function body.

func _on_new_game_create() -> void:
  get_tree().change_scene_to(game_scene)

func _on_new_game_cancel() -> void:
  new_game_dialog.visible = false


func _on_load_game_pressed() -> void:
  pass # Replace with function body.


func _on_game_settings_pressed() -> void:
  pass # Replace with function body.


func _on_quit_game_pressed() -> void:
  pass # Replace with function body.

func _exit_tree() -> void:
  queue_free()

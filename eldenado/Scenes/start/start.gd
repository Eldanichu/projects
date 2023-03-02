extends Control

onready var game_scene = preload("res://Scenes/game/game.tscn")
onready var new_game = get_node("%dlg_new_game")

func _ready() -> void:

	pass

func _on_start_game_pressed() -> void:
	new_game.visible = true
	pass

func _on_dlg_new_game_create(info:Dictionary) -> void:
	new_game.visible = false

func _on_dlg_new_game_cancel() -> void:
	new_game.visible = false


func _on_load_game_pressed() -> void:
	pass


func _on_game_settings_pressed() -> void:
	pass


func _on_quit_game_pressed() -> void:
	pass

func _exit_tree() -> void:
	queue_free()




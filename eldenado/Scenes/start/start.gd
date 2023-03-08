extends Control

onready var dlg_new_game := $"../../gui/dialogs/new_game"


func _ready() -> void:

	pass

func _on_start_game_pressed() -> void:
	print("start")
	dlg_new_game.visible = true

func _on_load_game_pressed() -> void:
	pass


func _on_game_settings_pressed() -> void:
	pass


func _on_quit_game_pressed() -> void:
	pass

func _exit_tree() -> void:
	queue_free()




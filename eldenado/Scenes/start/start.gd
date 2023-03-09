extends Control

export(NodePath) var UI

var dl_new_game := preload("res://UI/NewGame/new_game.tscn")
var dl_game_settings := preload("res://UI/GameSettings/game_setting.tscn")

func _on_start_game_pressed() -> void:
	var _dl = dl_new_game.instance()
	UI.add_child(_dl)
	_dl.connect("create_game",self,"game_creation")

func _on_load_game_pressed() -> void:
	pass

func _on_game_settings_pressed() -> void:
	var _dl = dl_game_settings.instance()
	UI.add_child(_dl)

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func game_creation(res):
	print(res)

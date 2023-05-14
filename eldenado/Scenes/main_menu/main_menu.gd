extends Control

export(NodePath) var UI

var dl_new_game := preload("res://UI/Panels/NewGame/new_game.tscn")
var dl_game_settings := preload("res://UI/Panels/GameSettings/game_setting.tscn")

var n := Notifer.new(self)

func _on_start_game_pressed() -> void:
	emit_audio()
	var _dl = dl_new_game.instance()
	UI.add_child(_dl)

func _on_load_game_pressed() -> void:
	emit_audio()
	pass

func _on_game_settings_pressed() -> void:
	emit_audio()
	var _dl = dl_game_settings.instance()
	UI.add_child(_dl)

func _on_quit_game_pressed() -> void:
	emit_audio()
	get_tree().quit()

func emit_audio():
	Event.emit_signal(Event.BUTTON_AUDIO.MENU_BUTTON)

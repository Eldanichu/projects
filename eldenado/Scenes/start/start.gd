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
	var player = Store.player
	player.player_name = info.c_name
	player.set_player_class(info.c_class)
	var _class_name = player.get_class_name()
	print_debug('[create charecter] name:{0},class:{1}'.format([info.c_name,_class_name]))
	get_tree().change_scene_to(game_scene)

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




@tool
extends EditorPlugin

const PLUGIN_NAME = "Inner Game"

var main_scene:Node

var _this:VBoxContainer:
	get:
		return EditorInterface.get_editor_main_screen()

func _enter_tree() -> void:
	_create()

func _exit_tree() -> void:
	_dispose()

func _apply_changes() -> void:
	_dispose()
	_create()
	main_scene.hide()

func _has_main_screen():
	return true

func _get_plugin_name() -> String:
	return PLUGIN_NAME

func _create():
	main_scene = preload("res://addons/inter_game/scene/interface.tscn").instantiate() as CustomInterface
	main_scene.name = PLUGIN_NAME
	_this.add_child(main_scene)
	main_scene.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	main_scene.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_make_visible(false)
	
	
func _make_visible(visible:bool):
	if main_scene:
		main_scene.visible = visible

func _dispose():
	if main_scene:
		main_scene.queue_free()

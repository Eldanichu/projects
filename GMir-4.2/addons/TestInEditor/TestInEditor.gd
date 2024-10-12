@tool
extends EditorPlugin

var _plugin_name = "Test Editor"

var u_scene0

func _enter_tree() -> void:
	print("[plugin] _enter_tree")
	_create()
	

func _apply_changes() -> void:
	print("[plugin] _apply_changes")
	_reload()

func _exit_tree() -> void:
	print("[plugin] _exit_tree")
	_dispose()

func _create():
	if not u_scene0:
		u_scene0 = preload("res://addons/TestInEditor/test_edior/test_scene.tscn").instantiate()
		_add_main_screen(u_scene0,_plugin_name)
		_make_visible(false)

func _dispose():
	if u_scene0:
		u_scene0.queue_free()
		u_scene0 = null

func _show_panel():
	make_bottom_panel_item_visible(u_scene0)

func _reload():
	_dispose()
	_create()

func _make_visible(visible:bool):
	if u_scene0:
		u_scene0.visible = visible

func _has_main_screen():
	return true

func _get_plugin_name() -> String:
	return _plugin_name

func _add_main_screen(node:Node,plagin_name:String):
	_plugin_name = plagin_name 
	EditorInterface.get_editor_main_screen().add_child(node)

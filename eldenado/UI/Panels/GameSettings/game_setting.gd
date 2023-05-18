extends PanelContainer

onready var resolution_options:OptionButton = find_node('resolution_options')
onready var chk_fullscreen := $"%is_full_screen"
onready var chk_v_sync := $"%is_verticle_sync"
onready var skill_keys := $"%skill_keys"
var skill_key := preload("res://UI/Panels/GameSettings/skill_key.tscn")

var is_full_screen = false
var is_verticle_sync = false

func _ready() -> void:
	chk_fullscreen.pressed = Store.settings.fullscreen
	chk_v_sync.pressed = Store.settings.v_sync
	load_skill_keys()
	pass

func load_skill_keys():
	if not is_instance_valid(Store) and not "settings" in Store:
		print("Game Setting Class is not in AutoLoad.")
		return
	var settings = Store.settings
	var _kbs = settings.key_bindings
	for o in _kbs:
		var item = _kbs[o]
		if o == "sep":
			var sep := HSeparator.new()
			skill_keys.add_child(sep)
			continue
		var inst_skill_key = skill_key.instance()
		inst_skill_key.name = o
		inst_skill_key.get_node("button").connect("button_up",self,"_on_binding_key",[o])
		inst_skill_key.get_node("label").text = o
		if item["key_code"] == -1:
			inst_skill_key.get_node("key_name").text = "-"
		skill_keys.add_child(inst_skill_key)
		print(_kbs[o])
	pass

func _on_binding_key(node_name):
	var node := skill_keys.get_node(node_name)
	print(node_name,node)
	pass

func close_dialog():
	queue_free()

func _on_close_pressed() -> void:
	close_dialog()

func _on_is_full_screen_toggled(button_pressed: bool) -> void:
	is_full_screen = button_pressed
	Store.settings.fullscreen = button_pressed

func _on_is_verticle_sync_toggled(button_pressed: bool) -> void:
	is_verticle_sync = button_pressed
	Store.settings.v_sync = button_pressed

func _on_save_pressed() -> void:
	OS.set_window_fullscreen(is_full_screen)
	OS.set_use_vsync(is_verticle_sync)

	close_dialog()

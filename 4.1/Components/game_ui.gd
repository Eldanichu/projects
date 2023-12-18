extends Control

@export
var player_scene:GamePlayer:set = set_player_scene

@onready var stats:Stats = get_node("%stats")
@onready var char_stat:CharStat = %char_stat

@onready var ui_func_box = %ui_func_box
@onready var ui_func_buttons = %ui_func_buttons
@onready var battle:BattleScene = %battle

var current_display_box:String = ""

func _ready():
	hide_all_func_box()
	bind_events()

func set_player_scene(value):
	player_scene = value
	setup()

func setup():
	stats.player_scene = player_scene
	char_stat.player_scene = player_scene
	char_stat.bind_event()

func bind_events():
	battle.ended.connect(_on_battle_end)
	var _ui_func_buttons = ui_func_buttons.get_children()
	var _button:Button
	for button in _ui_func_buttons:
		_button = button
		_button.pressed.connect(_on_ui_func_button.bind(button.name))

func hide_all_func_box():
	var eqs = get_tree().get_nodes_in_group("player_eq")
	var _eq:GearSlot
	for eq in eqs:
		_eq = eq
	var ui_func_boxes = ui_func_box.get_children()
	for box in ui_func_boxes:
		ControlUtil.hide_control(box)

func _on_ui_func_button(type:String):
	toggle_panel(type)

func toggle_panel(type:String):
	var control = ui_func_box.get_node_or_null(current_display_box)
	if control != null:
		ControlUtil.hide_control(control)
	
	control = ui_func_box.get_node_or_null(type)
	if control == null:
		current_display_box = ""
		return
	if type == current_display_box:
		ControlUtil.hide_control(control)
		current_display_box = ""
	else:
		ControlUtil.show_control(control)
		current_display_box = type

func _on_map_map_click(id, name_str):
	battle.player_scene = player_scene
	battle.set_map(id)

func _on_battle_end():
	setup()
	player_scene.player.revive()
		


extends Control

signal switch_panel(panel_name)

func _ready() -> void:
	var btns = get_tree().get_nodes_in_group("game_func_btn")
	for btn in btns:
		btn.connect("pressed",self,"_func_call",[btn.name])

func _func_call(panel_name):
	emit_signal("switch_panel",panel_name)

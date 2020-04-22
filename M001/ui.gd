extends Control
class_name UI

onready var l_exp_val = $top/v/m3/HBoxContainer3/p_exp/lbl_exp_val

var props= Props.new();

func _ready():
	props.init_level()
	pass

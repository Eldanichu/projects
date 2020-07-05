extends Control

onready var p_hp = $top/v/HBoxContainer/p_hp
onready var l_hp = $top/v/HBoxContainer/l_hp

onready var p_mp = $top/v/HBoxContainer/p_mp
onready var l_mp = $top/v/HBoxContainer/l_mp

onready var p_exp = $top/v/HBoxContainer/p_exp
onready var l_exp = $top/v/HBoxContainer/l_exp

func _ready():
	_bind_events()

func on_hp_changed(v):
	print(v)

func _bind_events():
	p_hp.connect("value_changed",self,'on_hp_changed',[p_hp.value, p_hp.max_value])

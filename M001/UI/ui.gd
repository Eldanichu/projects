extends Control

signal hp_change(v)

onready var p_hp = $top/v/HBoxContainer/p_hp
onready var l_hp = $top/v/HBoxContainer/l_hp

onready var p_mp = $top/v/HBoxContainer/p_mp
onready var l_mp = $top/v/HBoxContainer/l_mp

onready var p_exp = $top/v/HBoxContainer/p_exp
onready var l_exp = $top/v/HBoxContainer/l_exp

onready var logger= $center/rtl



func _ready():
	_bind_events()
	addMsg('sdfasdf')
	addMsg('sdfasdf')
	addMsg('sdfasdf')
	loadMsg();

func on_hp_changed(v):
	emit_signal('hp_change',v);

func _bind_events():
	p_hp.connect("value_changed",self,'on_hp_changed',[p_hp.value, p_hp.max_value])
	

func addMsg(msg):
	var res =logger.append_bbcode(str('\n',msg))

func loadMsg():
	pass

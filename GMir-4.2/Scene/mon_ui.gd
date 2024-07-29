extends PanelContainer
class_name MonUI

@onready var m_name = %m_name
@onready var u_hp = %hp
@onready var u_mp = %mp
@onready var u_action = %action

@export
var mname:String:
	set(value):
		m_name.set_deferred("text",value)

@export
var hp:int:
	set(value):
		if u_hp:
			u_hp.set_deferred("v",value)

@export
var hp_max:int:
	set(value):
		u_hp.set_deferred("vmax",value)

@export
var mp:int:
	set(value):
		if u_mp:
			u_mp.set_deferred("v",value)

@export
var mp_max:int:
	set(value):
		u_mp.set_deferred("vmax",value)

@export
var action:float:
	set(value):
		u_action.set_deferred("interval",value)
		u_action.call_deferred("start")

func _ready():
	u_hp.v = hp
	u_mp.v = mp




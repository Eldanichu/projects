extends PanelContainer
class_name MonUI

@export
var hp:int:
	set(value):
		call_deferred("_set_u_hp",value)

@export
var hp_max:int:
	set(value):
		call_deferred("_set_u_hp_max",value)

@export
var mp:int:
	set(value):
		call_deferred("_set_u_mp",value)

@export
var mp_max:int:
	set(value):
		call_deferred("_set_u_mp_max",value)

@onready var u_hp = %hp
@onready var u_mp = %mp

func _ready():
	u_hp.v = hp
	u_mp.v = mp
	
func _set_u_hp(value):
	u_hp.v = value

func _set_u_hp_max(value):
	u_hp.vmax = value	

func _set_u_mp(value):
	u_mp.v = value

func _set_u_mp_max(value):
	u_mp.vmax = value	

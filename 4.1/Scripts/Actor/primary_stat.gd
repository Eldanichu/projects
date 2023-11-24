extends BaseStat
class_name PrimaryStat

const EXP_INC_RATIO = 1.05

var _actor_class

var HP = 16:
	set(v):
		var var_name = "HP"
		_on_change(var_name, HP, true)
		HP = v
		_on_change(var_name, v)
var HPMAX = 16:
	set(v):
		_on_change("HPMAX", HPMAX, true)
		HPMAX = v
		_on_change("HPMAX", v)
var MP = 15:
	set(v):
		_on_change("MP", MP, true)
		MP = v
		_on_change("MP", v)
var MPMAX = 15:
	set(v):
		_on_change("MPMAX", MPMAX, true)
		MPMAX = v
		_on_change("MPMAX", v)
var EXP = 0:
	set(v):
		_on_change("EXP", EXP, true)
		EXP = v
		_on_change("EXP", v)
var EXPMAX = 50:
	set(v):
		_on_change("EXPMAX", EXPMAX, true)
		EXPMAX = v
		_on_change("EXPMAX", v)
var LEVEL = 1:
	set(v):
		_on_change("LEVEL", LEVEL, true)
		LEVEL = v
		_on_change("LEVEL", v)


const variables = [
	"HP","HPMAX",
	"MP","MPMAX",
	"EXP","EXPMAX",
	"LEVEL"
]

func _init():
	pass

func set_class(actor_class:BaseActorClass):
	_actor_class = actor_class

func get_properties() -> Dictionary:
	var dict:Dictionary = {}
	for key in variables:
		dict[key] = self[key]

	return dict

func update():
	if _actor_class as TaoClass:
		_actor_class.update()




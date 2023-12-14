extends BaseStat
class_name SecondaryStat

var ATTACK = 2:
	set(v):
		var var_name = "ATTACK"
		_on_change(var_name, ATTACK, true)
		ATTACK = v
		_on_change(var_name, v)

var	ATTACK_SPEED = 400:
	set(v):
		var var_name = "ATTACK_SPEED"
		_on_change(var_name, ATTACK_SPEED, true)
		ATTACK_SPEED = v
		_on_change(var_name, v)
var	CAST_SPEED = 450:
	set(v):
		var var_name = "CAST_SPEED"
		_on_change(var_name, CAST_SPEED, true)
		CAST_SPEED = v
		_on_change(var_name, v)

var	CRITICAL_CHANCE = 10:
	set(v):
		var var_name = "CRITICAL_CHANCE"
		_on_change(var_name, CRITICAL_CHANCE, true)
		CRITICAL_CHANCE = v
		_on_change(var_name, v)
var	CRITICAL_DAMAGE = 5:
	set(v):
		var var_name = "CRITICAL_DAMAGE"
		_on_change(var_name, CRITICAL_DAMAGE, true)
		CRITICAL_DAMAGE = v
		_on_change(var_name, v)

var	DEFENCE = 0:
	set(v):
		var var_name = "DEFENCE"
		_on_change(var_name, DEFENCE, true)
		DEFENCE = v
		_on_change(var_name, v)

var	DFIRE = 0:
	set(v):
		var var_name = "DFIRE"
		_on_change(var_name, DFIRE, true)
		DFIRE = v
		_on_change(var_name, v)
var	DICE = 0:
	set(v):
		var var_name = "DICE"
		_on_change(var_name, DICE, true)
		DICE = v
		_on_change(var_name, v)
var	DWIND = 0:
	set(v):
		var var_name = "DWIND"
		_on_change(var_name, DWIND, true)
		DWIND = v
		_on_change(var_name, v)
var	DWATER = 0:
	set(v):
		var var_name = "DWATER"
		_on_change(var_name, DWATER, true)
		DWATER = v
		_on_change(var_name, v)

var	RFIRE = 0:
	set(v):
		var var_name = "RFIRE"
		_on_change(var_name, RFIRE, true)
		RFIRE = v
		_on_change(var_name, v)
var	RICE = 0:
	set(v):
		var var_name = "RICE"
		_on_change(var_name, RICE, true)
		RICE = v
		_on_change(var_name, v)
var	RWIND = 0:
	set(v):
		var var_name = "RWIND"
		_on_change(var_name, RWIND, true)
		RWIND = v
		_on_change(var_name, v)
var	RWATER = 0:
	set(v):
		var var_name = "RWATER"
		_on_change(var_name, RWATER, true)
		RWATER = v
		_on_change(var_name, v)

func _init():
	set_variables([
		"ATTACK","ATTACK_SPEED","CAST_SPEED",
		"DFIRE","DICE","DWIND","DWATER",
		"RFIRE","RICE","RWIND","RWATER",
		"DEFENCE",
		"CRITICAL_CHANCE","CRITICAL_DAMAGE",
	])




extends BaseStat
class_name PrimaryStat

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

func _init():
	set_variables([
		"HP",
		"HPMAX",
		"MP",
		"MPMAX",
		"EXP",
		"EXPMAX",
		"LEVEL"
	])




extends BaseStat
class_name MonStat

var DNAME:
	set(v):
		var var_name = "DNAME"
		_on_change(var_name, DNAME, true)
		DNAME = v
		_on_change(var_name, v)
	
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

var ATK = 2:
	set(v):
		var var_name = "ATK"
		_on_change(var_name, ATK, true)
		ATK = v
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

var	DEF = 0:
	set(v):
		var var_name = "DEF"
		_on_change(var_name, DEF, true)
		DEF = v
		_on_change(var_name, v)

var	AGI = 0:
	set(v):
		var var_name = "AGI"
		_on_change(var_name, AGI, true)
		AGI = v
		_on_change(var_name, v)

var LEVEL = 1:
	set(v):
		_on_change("LEVEL", LEVEL, true)
		LEVEL = v
		_on_change("LEVEL", v)

var ATK_INTERVAL = 100:
	set(v):
		var var_name = "ATK_INTERVAL"
		_on_change(var_name, ATK_INTERVAL, true)
		ATK_INTERVAL = v
		_on_change(var_name, v)

func _init():
	set_variables([
		"DNAME",
		"HP",
		"HPMAX",
		"MPMAX",
		"ATK",
		"ATTACK_SPEED",
		"CAST_SPEED",
		"CRITICAL_CHANCE",
		"DEF",
		"AGI",
		"LEVEL",
	])






extends BaseStat
class_name MonStat

var DNAME = "UnnamedMonster"
var ATK = 2
var	DEF = 0
var	AGI = 0
var	ATKSPD = 1250
var	CASTSPD = 1450

var	CRITICAL_CHANCE = 10
var	CRITICAL_DAMAGE = 15

func _init():
	set_variables([
		"DNAME",
		"HP",
		"HPMAX",
		"MPMAX",
		"ATK",
		"ATKSPD",
		"CASTSPD",
		"CRITICAL_CHANCE",
		"DEF",
		"AGI",
		"LEVEL",
	])




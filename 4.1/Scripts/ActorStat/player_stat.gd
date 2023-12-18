extends BaseStat
class_name PlayerStat

var ATK = 0
var	DEF = 0
var	AGI = 0
var	ATKSPD = 1250
var	CASTSPD = 1450

var	CRITICAL_CHANCE = 10
var	CRITICAL_DAMAGE = 5

var	DFIRE = 0
var	DICE = 0
var	DWIND = 0
var	DWATER = 0

var	RFIRE = 0
var	RICE = 0
var	RWIND = 0
var	RWATER = 0


func _init():
	set_variables([
		"HP",
		"HPMAX",
		"MP",
		"MPMAX",
		"EXP",
		"EXPMAX",
		"LEVEL",
		"ATK","ATKSPD","CASTSPD",
		"DFIRE","DICE","DWIND","DWATER",
		"RFIRE","RICE","RWIND","RWATER",
		"AGI","DEF",
		"CRITICAL_CHANCE","CRITICAL_DAMAGE",
	])




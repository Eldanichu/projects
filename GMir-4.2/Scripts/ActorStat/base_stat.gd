extends RefCounted
class_name BaseStat

var HP = 0
var HPMAX = 0
var MP = 0
var MPMAX = 0
var EXP = 0
var EXPMAX = 0
var LEVEL = 1
var ATK_CHANCE = 55

var variables = []

func set_variables(vars:Array):
	variables = vars

func get_properties() -> Dictionary:
	var dict:Dictionary = {}
	for key in variables:
		dict[key] = self[key]

	return dict



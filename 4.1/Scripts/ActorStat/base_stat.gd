extends RefCounted
class_name BaseStat

var HP = 16
var HPMAX = 16
var MP = 15
var MPMAX = 15
var EXP = 0
var EXPMAX = 50
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



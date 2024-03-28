extends Node
class_name Properties

var prop:Dictionary = {}

var hp:int:
	get:
		return OUtil.get_propi(prop, "hp")
	set(value):
		prop["hp"] = value
var hp_max:int:
	get:
		return prop["hp_max"]
	set(value):
		prop["hp_max"] = value

var mp:int:
	get:
		return prop["mp"]
	set(value):
		prop["mp"] = value
var mp_max:int:
	get:
		return prop["mp_max"]
	set(value):
		prop["mp_max"] = value

var expv:int:
	get:
		return prop["expv"]
	set(value):
		prop["expv"] = value
var expv_max:int:
	get:
		return prop["expv_max"]
	set(value):
		prop["expv_max"] = value

var level:int:
	get:
		return prop["level"]
	set(value):
		prop["level"] = value







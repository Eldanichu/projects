extends Node
class_name EnityTest

var properties:Dictionary = {}

var hp:int:
	get:
		return OUtil.get_propi(properties, "hp")
	set(value):
		properties["hp"] = value
var hp_max:int:
	get:
		return properties["hp_max"]
	set(value):
		properties["hp_max"] = value

var mp:int:
	get:
		return properties["mp"]
	set(value):
		properties["mp"] = value
var mp_max:int:
	get:
		return properties["mp_max"]
	set(value):
		properties["mp_max"] = value

var expv:int:
	get:
		return properties["expv"]
	set(value):
		properties["expv"] = value
var expv_max:int:
	get:
		return properties["expv_max"]
	set(value):
		properties["expv_max"] = value

var level:int:
	get:
		return properties["level"]
	set(value):
		properties["level"] = value







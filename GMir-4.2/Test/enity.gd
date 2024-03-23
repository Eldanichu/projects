extends Node
class_name EnityTest

var properties:Dictionary = {}

var hp:int:
	get:
		return properties["hp"]
	set(value):
		properties["hp"] = value
var mp:int



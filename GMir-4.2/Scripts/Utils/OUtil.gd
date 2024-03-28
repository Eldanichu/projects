extends RefCounted
class_name OUtil

static func get_propf(properties:Dictionary, key:String) -> float:
	if not key in properties:
		return 0.0
	return properties[key]

static func get_propi(properties:Dictionary, key:String) -> int:
	if not key in properties:
		return 0
	return properties[key]

static func get_propstr(properties:Dictionary, key:String) -> String:
	if not key in properties:
		return ""
	return properties[key]

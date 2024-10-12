extends RefCounted
class_name OUtil

static func get_prop(properties:Dictionary, key:String) -> Callable:
	if not key in properties:
		return Callable()
	return properties[key]

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

func get_selected_enums(enum_var:Dictionary, flag_var:int):
	var _enum = enum_var
	var count = -1
	var arr = []
	for item in _enum:
		count = count + 1
		var bit:int = int(pow(2,_enum[item]))
		if flag_var & bit:
			arr.append(count)
	return arr

func set_selected_enums(enum_vars:Array) -> int:
	var bit = 0
	for index in range(0,len(enum_vars)):
		bit += int(pow(2,enum_vars[index]))
	return bit

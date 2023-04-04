extends Resource
class_name StringUtil

static func isEmptyOrNull(arg:String) -> bool:
	return arg == "" || arg == null

static func trim(string:String) -> String:
	return string.strip_escapes();

static func is_gold(gold_str:String):
	var _str := gold_str.split(" ")
	if _str.size() < 2:
		return [false]
	var gold_value := _str[1]
	return [(_str.has("gold") && gold_value.is_valid_integer()), int(gold_value)]

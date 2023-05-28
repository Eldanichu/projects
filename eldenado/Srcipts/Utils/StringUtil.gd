extends Resource
class_name StringUtil

static func isEmptyOrNull(arg) -> bool:
	return str(arg) == "" || arg == null

static func trim(string:String) -> String:
	return string.strip_escapes();

static func is_gold(gold_str:String):
	var _str := gold_str.split(" ")
	if _str.size() < 2:
		return [false]
	var gold_value := _str[1]
	return [(_str.has("gold") && gold_value.is_valid_integer()), int(gold_value)]

static func gen_id(length:int = 12):
	var rnd := RandomNumberGenerator.new()
	rnd.randomize()
	var string = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890"
	var str_len = string.length()
	var new_str = ""
	for i in range(length):
		var string_index = rnd.randi_range(0,str_len)
		var c = string.substr(string_index, 1)
		new_str += c
	return new_str

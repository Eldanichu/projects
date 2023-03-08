extends Reference
class_name StringUtil

static func isEmptyOrNull(arg:String) -> bool:
	return arg == "" || int(arg) != 0 || arg == null

static func trim(string:String) -> String:
	return string.strip_escapes();


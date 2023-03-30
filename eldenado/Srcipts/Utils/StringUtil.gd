extends Resource
class_name StringUtil

static func isEmptyOrNull(arg:String) -> bool:
	return arg == "" || arg == null

static func trim(string:String) -> String:
	return string.strip_escapes();

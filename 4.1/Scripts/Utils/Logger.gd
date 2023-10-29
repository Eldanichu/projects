extends Node
class_name log

class CLog:

	func _init():
		pass
	
	func debug(str0,str1):
		var call_from = get_stack_dict()
		if !len(call_from.keys()):
			return
		var prefix = "\t [DEBUG] - {time}_{ms}  [i]{func}[/i]@[color=#{path_color}][u]{source}[/u][/color]:{line} - {str0} {str1}".format({
			"time":Time.get_datetime_string_from_system(),
			"ms":Time.get_ticks_usec() / 1000.0,
			"line":call_from["line"],
			"func":call_from["function"],
			"source":call_from["source"],
			"path_color":Color.SKY_BLUE.to_html(),
			"str0":str(str0),
			"str1":str(str1),
		})
		print_rich(prefix)
	
	func get_stack_dict() -> Dictionary:
		var _stack:Array = get_stack()
		var len_stack = len(_stack)
		if !len_stack:
			return {}
		var call_from:Dictionary = _stack[len_stack - 1]
		return call_from

static func d(str0 = "", str1 = ""):
	return CLog.new().debug(str0,str1)

extends Node
class_name log

class CLog:

	func _init():
		pass
	
	func debug(str0,str1):
		var call_from = get_stack_dict()
		var prefix = "\t [DEBUG]{L:{line}} - {time}_{ms}  [i]{func}[/i]@[color=#{path_color}][u]{source}[/u][/color] - {str0} {str1}".format({
			"time":Time.get_datetime_string_from_system(),
			"ms":Time.get_ticks_usec() / 1000.0,
			"line":call_from["line"],
			"func":call_from["function"],
			"source":call_from["source"],
			"path_color":Color(0.647059, 0.164706, 0.164706, 1).to_html(),
			"str0":str(str0),
			"str1":str(str1),
		})
		print_rich(prefix)
	
	func get_stack_dict() -> Dictionary:
		var _stack:Array = get_stack()
		var len_stack = len(_stack)
		var call_from:Dictionary = _stack[3]
		return call_from

static func d(str0 = "", str1 = ""):
	return CLog.new().debug(str0,str1)
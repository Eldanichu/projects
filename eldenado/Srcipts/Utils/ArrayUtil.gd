extends Resource
class_name ArrayUtil
	

static func copy_deep(array:Array):
	return array.duplicate(true)

static func join(array:Array, spliter:String = "",keep_last = false) -> String:
	var _text = ""
	for _t in array:
		_text = str(_text , _t , spliter)

	return _text if keep_last else _text.rstrip(spliter)
	
static func dict2Array(dict:Dictionary) -> Array:
	var array:Array = []
	var keys = dict.keys()
	var size = keys.size()
	for i in range(size):
		var o = dict[keys[i]]
		array.append(o)
	return array

static func array2Dictionary(array:Array, as_key:String) -> Dictionary:
	var dict:Dictionary = {}
	var size = array.size()
	for i in range(size):
		var o = array[i]
		dict[o[as_key]] = o
	return dict

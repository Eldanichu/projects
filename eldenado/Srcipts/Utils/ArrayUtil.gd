extends Node
class_name ArrayUtil

static func copy_deep(array:Array):
	return array.duplicate(true)
	pass

static func join(array:Array, spliter:String = "",keep_last = false):
	var _text = ""
	for _t in array:
		_text = str(_text , _t , spliter)

	return _text if keep_last else _text.rstrip(spliter)


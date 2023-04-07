extends Resource
class_name ObjectUtil

static func get_ref(obj):
	return weakref(obj).get_ref()

static func is_null(obj):
	if(obj == null):
		return true
	var _ref = get_ref(obj)
	if _ref == null:
		return true
	return false

static func entries(object:Dictionary,callback:FuncRef):
	var keys = object.keys()
	var values = object.values()
	for i in range(0,keys.size()):
		callback.call_func(keys[i],values[i])

static func is_null_or_empty(obj:Dictionary):
	var _keys = obj.keys()
	return _keys.size()

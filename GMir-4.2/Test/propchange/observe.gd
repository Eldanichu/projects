extends RefCounted
class_name Observe

const REACTIVE_VAR_SUFFIX = "_vm"

var _this:Observe
var value:Dictionary = {}


func _init(this):
	print(this is MMProp)
	_this = this
	_update_properties()

func _update_properties():
	var props = _this.get_property_list()
	var _var_name:String
	for prop in props:
		_var_name = prop.name as String
		if not is_react_var(_var_name):
			continue
		value[_var_name] = self[_var_name]

func update():
	_update_properties()


func is_react_var(_var_name:String):
	return _var_name.ends_with(REACTIVE_VAR_SUFFIX)

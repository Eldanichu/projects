extends RefCounted
class_name BaseStat

var _changed:Dictionary = {}
var _events = {}

func add_event(callback:Callable,id:String = "__default"):
	_events[id] = callback
	trigger_event()

func _on_change(stat_name:String, value = null, is_before:bool = false):
	var value_changing = {
		"old_value":null,
		"new_value":value
	}
	if is_before:
		value_changing["old_value"] = value
	_changed[stat_name] = value_changing
	trigger_event()

func trigger_event():
	var _method:Callable
	for key in _events:
		_method = _events[key]
		if _method.is_null():
			return
		_method.bind(_changed).call()



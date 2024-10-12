extends RefCounted
class_name DArray

var _dict:Dictionary = {}
var _dict_len:int = 0

var _first_id:String = ""
var _prev_id:String = ""

var _rid = ResourceUID

func _init() -> void:
	_update()

func push(object,id = null):
	var _id = _node_id(id)
	_dict[_id] = object
	_update()
	_set_prev(_id)

func pop():
	if not _has_prev() or not _prev_id in _dict:
		_update()
		return null
	var _temp = _dict[_prev_id]
	_dict.erase(_prev_id)
	_update()
	return _temp

func shift():
	if not _has_first() or not _first_id in _dict:
		_update()
		return null
	var _temp = _dict[_first_id]
	_dict.erase(_first_id)
	_update()
	return _temp

func get_key(key:String):
	return _dict[key]

func set_v_key(key:String,value):
	_dict[key] = value

func remove_key(key:String):
	print(_dict[key])
	_dict.erase(key)
	print(_dict)
	_update()

func null_value(val):
	if  not val or str(val) == "":
		return ""
	return val

func dictionary() -> Dictionary:
	return _dict

func _update():
	var _size = _dict.size()
	_dict_len = _size
	_set_first()

func _node_id(id:String):
	var _id = id
	if id == null:
		_id = _rid.create_id()
	return "d_{0}".format([
		_id
	])

func _set_first():
	var keys = _dict.keys()
	if keys.size() <=0:
		_first_id = ""
		return
	_first_id = null_value(keys[0])

func _set_prev(uid):
	if _dict_len <= 0:
		_prev_id = ""
		return
	_prev_id = null_value(uid)

func _has_first():
	return _first_id != ""

func _has_prev():
	return _prev_id != ""

extends Resource
class_name AttackBase

var cast setget set_cast
var target setget set_target

var obj:Dictionary = {} setget set_obj,get_obj
var cd:float = 0.1 setget set_cd,get_cd
var disabled:bool = false setget set_disabled,get_disable

func set_cast(_cast):
	cast = _cast
	return self

func set_target(_target):
	target = _target
	return self

func set_obj(_obj:Dictionary):
	obj.merge(_obj, true)

func get_obj() -> Dictionary:
	return obj

func get_cd() -> float:
	return cd

func set_cd(value:float = 0.1):
	obj["cd"] = value

func set_disabled(value:bool):
	obj["disabled"] = value

func get_disable():
	return obj["disabled"]

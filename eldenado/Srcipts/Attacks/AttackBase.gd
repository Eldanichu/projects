extends Resource
class_name AttackBase

var cast:PlayerObj setget from
var target:MonObj setget to

var obj:Dictionary = {} setget set_obj,get_obj
var cd = 0.2 setget ,get_cd

var type

func _init():
	pass

func from(_cast):
	cast = _cast
	return self

func to(_target):
	target = _target
	return self

func _is_valid_attack():
	return cast && target

func set_obj(_obj:Dictionary):
	obj = _obj

func get_obj() -> Dictionary:
	return obj

func get_cd() -> float:
	return cd

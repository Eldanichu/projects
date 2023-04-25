extends Node
class_name BaseAttack

var can_attack:bool = false
var cooldown = -1
var cast = null
var target = null


func _init():
	return self

func _ready() -> void:
	pass

func from(_cast):
	cast = _cast
	return self

func to(_target):
	target = _target
	return self

func cd(value):

	return self

func cdr_percent(value):

	return self

func cdr_value(value):

	return self



func _is_valid_attack():
	return cast && target

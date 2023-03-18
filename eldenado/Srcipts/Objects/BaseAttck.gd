extends Node
class_name BaseAttack

var can_attack:bool = false
var cooldown = -1
var cast = null
var target = null

var attack_timer := AdjustableTimer.new(self)

func _init():
	return self

func _ready() -> void:
	if !_is_valid_attack():
		queue_free()
	add_child(attack_timer)
	
func from(_cast):
	cast = _cast
	return self

func to(_target):
	target = _target
	return self

func cd(value):
	cooldown = value
	attack_timer.Interval = cooldown
	attack_timer.start_timer()
	return self

func cdr_percent(value):
	attack_timer.reduce_amount(value,"%")
	return self

func cdr_value(value):
	attack_timer.reduce_amount(value,"N")
	return self



func _is_valid_attack():
	return cast && target

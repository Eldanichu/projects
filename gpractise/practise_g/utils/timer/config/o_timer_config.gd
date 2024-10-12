extends Node
class_name OTimerConfig

var max_tick:int = 1:
	set(value):
		max_tick = value

var interval:float = 0:
	set(value):
		interval = value

func _init(interval_:float) -> void:
	interval = interval_

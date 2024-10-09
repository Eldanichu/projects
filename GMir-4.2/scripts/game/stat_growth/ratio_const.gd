extends RefCounted
class_name RatioConst

var v0_const:float = 0
var v0_base:float = 0
var v0_rate:float = 0
var v0_acc:float = 0

var v1_const:float = 0
var v1_base:float = 0
var v1_rate:float = 0
var v1_acc:float = 0

var _level:int = 1

func _init(level:int) -> void:
	_level = level

func value() -> int:
	return 0

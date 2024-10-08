extends RatioConst
class_name HPConst

func _init(level:int) -> void:
	super(level)
	v0_base = 60
	v0_acc = 25


func value() -> int:
	return v0_const + (int(_level / v0_base + v0_acc) * _level)

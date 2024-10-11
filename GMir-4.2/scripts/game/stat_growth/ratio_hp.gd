extends RatioConst
class_name HPConst

func _init(level:int) -> void:
	super(level)
	v0_const = 14
	v0_base = 15
	v0_rate = 2
	v0_acc = 1.052


func value() -> int:
	return v0_const + (int(_level / v0_base + v0_rate * v0_acc) * _level)

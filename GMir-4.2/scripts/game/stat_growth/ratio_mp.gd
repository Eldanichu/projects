extends RatioConst
class_name MPConst

func _init(level:int) -> void:
	super(level)
	v0_const = 13
	v0_base = 5
	v0_acc = 8
	v0_rate = 2
	

func value() -> int:
	return round(v0_const + (int(_level / v0_base + v0_rate) * v0_acc * _level))

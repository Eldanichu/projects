extends RatioConst
class_name DCConst

func _init(level:int) -> void:
	super(level)
	v0_const = 1
	v0_base = 1
	v0_acc = 1.1
	v0_rate = 0.5
	
	v1_const = 1
	v1_base = 0.1
	v1_acc = 1.2
	v1_rate = 0.16
	

func value() -> int:
	return int(v0_const+((_level/(v0_base + v0_acc))) * pow(v0_const, 1 - v0_rate))

func value_max() -> int:
	var res = v1_const+((_level/(v1_base + v1_rate) * v1_acc)) * pow(v1_base, 1 - v1_rate)
	return int(res)

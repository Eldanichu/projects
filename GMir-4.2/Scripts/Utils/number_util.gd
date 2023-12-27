extends RefCounted
class_name NumberUtil

static func apply_percentages(number:int, percentages:Array[int]):
	var a = number
	for p in percentages:
		a *= p / 100.0
	return int(a)

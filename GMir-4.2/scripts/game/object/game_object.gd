extends Node2D
class_name GameObject

var properties: BaseProperties


func _init():
	pass


func level_up():
	properties.level = properties.level + 1
	properties.expv = 0
	print("level up! current level={0}, max exp={1}".format([
	properties.level,
	properties.expv_max
	]))


func set_exp(amount: int, clear: bool = true):
	var remain: int = amount - properties.expv
	var _max = properties.expv_max
	if amount < _max:
		properties.expv = properties.expv + amount
	elif remain >= _max:
		properties.expv = remain - properties.expv_max
		remain = amount - properties.expv_max
		level_up()
		while remain >= _max:
			properties.expv = properties.expv + remain
			remain = amount - properties.expv_max
			if properties.expv >= properties.expv_max:
				level_up()
	if clear:
		properties.expv = 0


func dead():
	pass

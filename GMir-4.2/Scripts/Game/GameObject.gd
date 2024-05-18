extends Node2D
class_name GameObject

var properties:Properties = Properties.new()
var tick_pool:Array = []

func _init():pass

func level_up():
	properties.level = properties.level + 1
	properties.expv = 0
	properties.expv_max = properties.expv_max + (12 * properties.level)
	print("level up! current level={0}, max exp={1}".format([
		properties.level,
		properties.expv_max
	]))

func prop_set(key:String,value):pass
func prop_set_tick(key:String, value, interval:float):pass
func set_exp(amount:int):
	var remain:int = amount - properties.expv
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


func attack(target:GameObject):pass
func skill_attack(target:GameObject, skill):pass
func cast(target:GameObject, skill):pass

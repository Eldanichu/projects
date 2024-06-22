extends Node2D
class_name GameObject

var properties:BaseProperties

func _init():
	pass

func prop_set(key:String,value, oAct:String, oType:String = "0"):
	if oType == "%":
		_exec_oper(oAct, key, max(0, (N.I2F(value)) / N.I2F(100)))
	elif oType == "0":
		_exec_oper(oAct, key, max(0, value))

func prop_set_tick(key:String, value, max_value, options:Dictionary, update:Callable):
	var oInterval:float = options["interval"]
	var oTimes:int = options["times"]
	var oAct:String = options["action"] 
	var oType:String = options["type"] 

	var timer = TimerEx.new(self)
	timer.interval = oInterval
	timer.times = oTimes
	timer.loop = true
	timer.on_counting.connect(
		func(index):
			prop_set(key, value, oAct, oType)
			if not update.is_null():
				update.call_deferred()

			var _v = properties[key]
			if is_equal_approx(N.I2F(_v) , N.I2F(max_value)):
				timer.clear()
	)
	timer.start()

func level_up():
	properties.level = properties.level + 1
	properties.expv = 0
	print("level up! current level={0}, max exp={1}".format([
		properties.level,
		properties.expv_max
	]))

func set_exp(amount:int, clear:bool = true):
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
	if clear:
		properties.expv = 0

func dead():
	pass

func _exec_oper(action:String, key:String, value):
	if action == "+":
		properties[key] = properties[key] + value
	elif action == "-":
		properties[key] = properties[key] - value
	elif action == "*":
		properties[key] = properties[key] * value
	elif action == "/":
		properties[key] = properties[key] / value
	hook_property_conditions(key)

func hook_property_conditions(key:String):
	var value = properties[key]
	if key == "hp":
		if value <= 0:
			dead()


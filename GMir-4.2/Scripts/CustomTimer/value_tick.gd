extends TimerTick
class_name ValueTick

enum TICK_TYPE {
	PERCENT = 0,
	NUMBER
}

enum TICK_ACTION {
	PLUS = 0,
	MINUS,
	MUL,
	DIV
}

var properties:BaseProperties
var tick_type:TICK_TYPE = TICK_TYPE.NUMBER
var tick_action:TICK_ACTION

var TKey:String
var TValue
var max_value

var update_func:Callable

func _init(node:Node):
	super(node)
	if not node is GameObject:
		printerr("there is properties in object.")
		return
	_set_properties(node.properties)
	tick_method(_on_ticking)

func proc():
	_set_value(TKey,TValue)
	clear()

func set_tick_type(type:TICK_TYPE):
	tick_type = type
	return self

func set_tick_action(action:TICK_ACTION):
	tick_action = action
	return self

func _on_ticking(i:int):
	_set_value(TKey,TValue)
	if not update_func.is_null():
		update_func.call_deferred()
	_dispose()

func set_max_value(value):
	max_value = value

func _set_value(key:String, value):
	if tick_type == TICK_TYPE.PERCENT:
		_exec_oper(max(0, (N.I2F(value)) / N.I2F(100)))
	elif tick_type == TICK_TYPE.NUMBER:
		_exec_oper(value)

func _exec_oper(value):
	var key = TKey
	if tick_action == TICK_ACTION.PLUS:
		properties[key] = properties[key] + value
	elif tick_action == TICK_ACTION.MINUS:
		properties[key] = properties[key] - value
	elif tick_action == TICK_ACTION.MUL:
		properties[key] = properties[key] * value
	elif tick_action == TICK_ACTION.DIV:
		properties[key] = properties[key] / value

func _set_properties(prop:BaseProperties):
	properties = prop

func _dispose():
	var _v = properties[TKey]
	if is_equal_approx(N.I2F(_v) , N.I2F(max_value)):
		clear()

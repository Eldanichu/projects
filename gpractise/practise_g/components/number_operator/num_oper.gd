extends MarginContainer
class_name NumberOperator

signal value_change(val, n)

var max:int = 999999999:
	set(v):
		max = v
		disabled_which()

@onready var value: Label = %value
@onready var dec: Button = %dec
@onready var inc: Button = %inc

@export
var disabled:bool = false:
	set(v):
		disabled = v
		_make_disable(v)
	get:
		return disabled
@export
var allow_negtive:bool = false

var _value:int = 0:
	set(v):
		_value = min(v,max)
		if value:
			value.call_deferred("set_text",str(_value))
		disabled_which()
	get:
		return _value

func _ready() -> void:
	_notify()

func _notify():
	_make_disable(disabled)
	disabled_which()
	

func _on_dec_button_up() -> void:
	_value = _value - 1
	if _value <= 0:
		if not allow_negtive:
			_value = 0
	value_change.emit(_value, -1)

func _on_inc_button_up() -> void:
	_value = _value + 1
	value_change.emit(_value, 1)

func disable_dec(v:bool):
	if dec:
		dec.call_deferred("set_disabled", v)

func disable_inc(v:bool):
	if inc:
		inc.call_deferred("set_disabled", v)

func _make_disable(v:bool):
	disable_inc(v)
	disable_dec(v)


func disabled_which():
	if disabled:
		return
	if not allow_negtive:
		disable_dec(_value <= 0)
	disable_inc( _value >= max)

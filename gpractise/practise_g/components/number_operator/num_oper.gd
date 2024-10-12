extends MarginContainer
class_name NumberOperator

signal value_change(val)

const MAX_VALUE:int = 999999999

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
		_value = min(v,MAX_VALUE)
		if value:
			value.call_deferred("set_text",str(_value))
		value_change.emit(_value)
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
	if not allow_negtive:
		if _value <= 0:
			_value = 0

func _on_inc_button_up() -> void:
	_value = _value + 1

func _disable_dec(v:bool):
	if dec:
		dec.call_deferred("set_disabled", v)

func _disable_inc(v:bool):
	if inc:
		inc.call_deferred("set_disabled", v)

func _make_disable(v:bool):
	_disable_dec(v)
	_disable_inc(v)

func disabled_which():
	if not allow_negtive:
		_disable_dec(_value <= 0)
	_disable_inc( _value >= MAX_VALUE)

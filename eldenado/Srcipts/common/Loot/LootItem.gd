extends Reference

class_name LootItem

var _name:String = ""
var _pty:float = 0.0 setget set_pty
var _tc:float = 0.0
var _rv:float = 0.0
var _rate:float = 0.0
var _is_always:bool = false setget set_always

func _init():
	self._name = _name
	self._pty = _pty
	self._tc = _tc
	self._rv = _rv
	self._rate = _rate
	self._is_always = _is_always

func set_pty(value:float):
	_pty = value
	return self

func set_always(value:bool):
	_is_always = value
	return self

func get_string():
	var _s = " name :-> [color=#0f0]{3}[/color]; _pty :-> {0}; tc :-> {1}; is_always :-> {2};\n".format([
	_pty,
	_tc,
	_is_always,
	_name
	])
	return _s

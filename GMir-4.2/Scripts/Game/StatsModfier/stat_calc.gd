extends Node
class_name StatCal

enum OPT {
	PERCENT,
	VALUE
}

var _value:int
var _amount:float
var _operator:OPT

func _init(value:int, amount:float, operator:OPT = OPT.PERCENT):
	_value = value
	_amount = amount
	_operator = operator

func add(modier:int = 0) -> StatCal:
	if _operator == OPT.PERCENT:
		var _mod = modier * _amount
		var _am = _value * _amount
		var t = _am +_mod
		_value = _value + t
	elif _operator == OPT.VALUE:
		_value = _value + (_amount + modier)
	return self

func minus(modier:int = 0) -> StatCal:
	if _operator == OPT.PERCENT:
		_value = _value - (_value * _amount) - (modier * _amount)
	elif _operator == OPT.VALUE:
		_value = _value - (_amount - modier)
	return self

func mult(modier:int) -> StatCal:
	if _operator == OPT.PERCENT:
		_value = _value * (_value * _amount) * (modier * _amount)
	elif _operator == OPT.VALUE:
		_value = _value * (_amount + modier)
	return self

func calc() -> int:
	return _value

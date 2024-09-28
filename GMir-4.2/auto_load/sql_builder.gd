extends RefCounted
class_name SqlBuilder

const COMMA_SEP:String = ","

var row:Dictionary = {}

var update_sets:Array = []
var column_values:Array = []
var columns:Array = []

func _init(row_:Dictionary):
	row = row_
	_normalized()

func _normalized():
	var _v
	for key in row:
		_v = [row[key]]
		update_sets.append(fmt_set(key, _v))
		columns.append(key)
		column_values.append(fmt_value(_v))


func fmt_value(value)->String:
	return "'{0}'".format(value)

func fmt_set(key:String,value)->String:
	return "{0}='{1}'".format([key,value])

func get_columns() -> String:
	return _sep_join(columns)

func get_column_values() -> String:
	return _sep_join(column_values)

func _sep_join(arr:Array) ->String:
	return COMMA_SEP.join(arr)

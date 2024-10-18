extends RefCounted
class_name SimpleLoot

const WEIGHT_KEY:String = "weight"

var rnd := RandomEx.get_instance()
var _data:Array = []

func _init(data:Array = []) -> void:
	_data = data
	roll()

func roll() -> Array:
	var drop_len = _data.size()
	var i = 0
	var res = []
	for item in _data:
		var rate = int(item[WEIGHT_KEY])
		if rate < 1:
			rate = 1
		var chance := rnd.randomi(rate)
		if chance != 0:
			continue
		res.append(item)
		i = i + 1
	return res

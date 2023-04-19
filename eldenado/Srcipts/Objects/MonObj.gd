extends Node
class_name MonObj


var mon_items:Dictionary = {}
var mon_stat:Dictionary = {

}

func _ready() -> void:
	pass


func drop(mon_name:String):
	var _items = mon_items[mon_name]
	if !_items || !_items.size():
		return []
	var drop_items = []
	var gold = 0
	for item in _items:
		var _chance = item[1]
		var _name = item[2]
		var can_drop = RandomUtil.get_random(_chance) > 0
		var _gold = StringUtil.is_gold(_name)
		if can_drop:
			if _gold[0]:
				gold = gold + _gold[1]
			else:
				drop_items.append(_name)
	drop_items.append("gold {0}".format([gold]))
	return drop_items

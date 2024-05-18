extends Node
class_name LootTable

class Loot:
	
	var KEY_ID:String = "id"
	var KEY_WEIGHT:String = "weight"
	var KEY_NAME:String = "name"
	var KEY_INDEX:String = "idx"
	var KEY_RV:String = "rare"
	var MAX_DROP_ITEM:int = 3
	var ROLLING_QTY:bool = true
	var UNROLLING_QTY:Array = [
		LT.QTY.LEGENDARY
	]
	
	var rnd = RandomEx.get_instance()
	
	var _data:Array = []
	
	var magic_find:float = 0.01
	var _qtys:Array = []
	var _always_drop_items:Array = []
	var _drop_list:Array = []
	
	
	func _init():
		pass
	
	func data(data:Array = []):
		_data = data.duplicate()
		magic_find_bonus()
		return self
	
	func is_unrolling(item):
		return (UNROLLING_QTY.has(item[KEY_RV]) || UNROLLING_QTY.has(int(item[KEY_RV])))
	
	func magic_find_bonus():
		var new_data = []
		for item in _data:
			if item[KEY_WEIGHT] < 50:
				item[KEY_WEIGHT] = item[KEY_WEIGHT] + (item[KEY_WEIGHT] * magic_find)
			else:
				item[KEY_WEIGHT] = item[KEY_WEIGHT]
			new_data.append(item)
		var copy_data = new_data.duplicate()
		_data = copy_data
	
	func roll_items():
		for item in _data:
			if item[KEY_WEIGHT] < 100 && rnd.hit(item[KEY_WEIGHT]) && not is_unrolling(item):
				_drop_list.append(item)
	
	func roll_items_qty(qty):
		for item in _data:
			if item[KEY_WEIGHT] < 100 && rnd.hit(item[KEY_WEIGHT]) && item[KEY_RV] == int(qty) && not is_unrolling(item):
				_drop_list.append(item)
	
	func get_items():
		# list all 100 of weight items as an Array
		# if 100 of weight items greater than MAX_DROP_ITEM, 
		# remove random items to keep other items drop chances
		for item in _data:
			if item[KEY_WEIGHT] == 100:
				_always_drop_items.append(item)
		roll_items()
		
		var _always_drop_items_len = len(_always_drop_items)
		if _always_drop_items_len >= MAX_DROP_ITEM:
			var remove_index = rnd.randomi(_always_drop_items_len - 1)
			_always_drop_items.remove_at(remove_index)
			_drop_list.append_array(_always_drop_items)
		# if ROLLING_QTY is true, make the qtys as an Array and randomly pick one for drop list
			if ROLLING_QTY:
				var picked_qty = pick_random_qty()
				roll_items_qty(picked_qty)
			else:
				roll_items()
		else:
			_drop_list.append_array(_always_drop_items)
	
		print(_drop_list)
		return _drop_list
	
	func pick_random_qty():
		for i in LT.QTY:
			_qtys.append(i)
		var _picked = RandomEx.get_instance().pick(_qtys)
		print(_picked)
		return _picked

static func get_instance() -> Loot:
	return Loot.new()

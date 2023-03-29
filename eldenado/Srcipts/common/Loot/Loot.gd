extends Resource
class_name LootTable

export var items := []

var rolling_count := 0
var rand_gen = RandomNumberGenerator.new()

class SortItemObject:
	static func sort_desc(a,b):
		return a['_pty'] > b['_pty']

	static func sort_by_tc_desc(a,b):
		return a['_tc'] > b['_tc']

	static func sort_asc(a,b):
		return a['_pty'] < b['_pty']

func add(item:LootItem) -> void:
	var _exists = find_item_by_name(item._name)
	if _exists:
		return
	item._rate = get_item_random_tc_value(item)
	items.append(item)

func remove(name:String) -> void:
	var _item = find_item_by_name(name)
	if !_item:
		return
	var _items_size := get_size()
	for i in range(0,_items_size):
		items.remove(i)

func set_item_index(index:int) -> void:
	pass

func set_item_name(name:String) -> void:
	pass

func roll(repeat:int = 1) -> Array:
	var _items = []
	for r in range(0,repeat):
		for i in items:
			rand_gen.randomize()
			var _rate = rand_gen.randi_range(0,i._rate)
			print(_rate)
			if _rate <= 0:
				_items.append(i)
		rolling_count = rolling_count + 1

	return _items

func roll_with_always() -> Array:
	var _items = []

	return _items

func get_size() -> int:
	return items.size()

func find_item_by_name(name:String) -> LootItem:
	var _items_size := get_size()
	var _item = null;
	if !_items_size:
		return null

	for i in items:
		if StringUtil.trim(name) == StringUtil.trim(i._name):
			_item = i
			continue
	return _item

func get_items_result() -> String:
	var _strs = []
	for i in items:
		_strs.append("  " + i._name + "  =>Rate: {0} ".format([ i._rate ]))
	return  " " + ArrayUtil.join(_strs,"\n")

func get_rolled_result(rolled_items:Array,verbose:bool = true) -> String:
	var _strs = []
	for i in rolled_items:
		_strs.append(i._name)
		if verbose:
			_strs.append("TC:{0} & pty:{1}".format([ i._tc, i._pty ]))
	return "\n --------"+str(rolling_count)+"------\n" + ArrayUtil.join(_strs,"\n")

func get_sorted_pty_list() -> Array:
	var list = items.duplicate(true)
	list.sort_custom(SortItemObject,'sort_desc')
	return list

func get_sorted_tc_list() -> Array:
	var list = items.duplicate(true)
	list.sort_custom(SortItemObject,'sort_by_tc_desc')
	return list

func get_item_random_tc_value(item:LootItem) -> float:
	# pty / ( rv / 10 ) * (1 - tc / 100)
	var value = (item._pty / ( item._rv / 10 )) * (1 - item._tc / 100)
	return value

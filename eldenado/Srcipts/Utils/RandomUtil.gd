extends Resource
class_name RandomUtil

static func get_random(chance:int):
	var _r = RandomNumberGenerator.new()
	_r.randomize()
	var n = _r.randf()
	var _c = 1.0 / (chance * 1.0)
	var res = 0
	if n < _c:
		 res = n
	return res

static func get_random_digit(chance:float):
	var _r = RandomNumberGenerator.new()
	_r.randomize()
	var n = _r.randf()
	var _c = chance * 1.0
	var res = 0.0
	if n < _c:
		 res = n
	return float(res)

static func get_items_random(count:int, array:Array) -> Array:
	var size = array.size()
	if size == 0:
		return []
	var _r = RandomNumberGenerator.new()
	_r.randomize()
	var copy = array.duplicate(true)
	var res = []
	var c = _r.randi() % count + 1
	for i in range(c):
		var n = _r.randi() % size
		res.append(copy[n])
	return res

static func get_map_monsters(db:DB, map_name:String) -> Array:
	var monster_group:Node = db.get_data('monster_group')
	if not monster_group or not monster_group["data"]:
		return []
	var data:Dictionary = monster_group.data
	if not data.has(map_name):
		return []
	var group = data.get(map_name)
	var mon_ids = get_items_random(group.n,group.g)
	return mon_ids

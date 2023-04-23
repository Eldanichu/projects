extends Node
class_name MonObj

var mon_items:Array = []
var mon_stat:Dictionary = {
	"name":null,
	"level":0,
	"atk_speed":1,
	"dc":0,
	"dc_max":0,
	"hp":0,
	"ac":0,
	"ac_max":0,
	"appr":null,
	"mp":0,
} setget set_stat

func get_instance(db:DB, mon_id:String):
	var _mon
	var monster:Node = db.get_data("monster")
	var textures = monster["textures"]
	var data:Dictionary = monster.data
	if not data.has(mon_id):
		_mon = null
	var props = data[mon_id]
	var _stat_keys = mon_stat.keys()
	for i in range(props.size()):
		var key = _stat_keys[i]
		if key == "appr":
			if props[i] in textures:
				mon_stat[key] = textures[props[i]]
		else:
			mon_stat[key] = props[i]
	set_drops(db)
	_mon = self
	print("mon instance->",mon_stat)
	print("test atteck->",attack())

func set_drops(db:DB):
	var mon_drop:Node = db.get_data("drop_item")
	var data:Dictionary = mon_drop.data
	var _mon_name = mon_stat.name
	if not data.has(_mon_name):
		mon_items = []
		return
	mon_items = data[_mon_name]

func set_stat(stat:Dictionary):
	mon_stat.merge(stat, true)

func can_attack():
	var _c1 = get_chance()
	var chance = RandomUtil.get_random_digit(_c1)

	return chance > 0

func attack():
	if !can_attack():
		return 0
	return get_power()

func get_power():
	var _r = RandomNumberGenerator.new()
	_r.randomize()
	var n = _r.randi_range(mon_stat.dc,mon_stat.dc_max)

	return n

func get_chance():
	var _ac = mon_stat.ac + mon_stat.ac_max * 1.0
	var _dc = mon_stat.dc + mon_stat.dc_max * 1.0
	var _speed_time:float = mon_stat.atk_speed / 1000.0
	var _level_speed_mod:float = mon_stat.level / mon_stat.atk_speed * 1.0
	var _c2:float = (_speed_time + _level_speed_mod) * 1.0
	var _c1 = _ac / max(1, _dc) * _c2 * 1.0
	print("mon attck chance->",_c1)
	return _c1

func drop():
	var _items = mon_items
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

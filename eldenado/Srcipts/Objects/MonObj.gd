extends Node
class_name MonObj


var mon_items:Dictionary = {}

var mon_stat:Dictionary = {
	"level":0,
	"hp":0,
	"mp":0,
	"atk_speed":0,
	"ac":0,
	"ac_max":0,
	"dc":0,
	"dc_max":0,
} setget set_stat

func _ready() -> void:
	pass

func set_stat(stat:Dictionary):
	for key in stat:
		mon_stat[key] = stat[key]

func can_attack():
	var _c1 = get_chance()
	var chance = RandomUtil.get_random_digit(_c1)

	return chance > 0

func attack():
	if !can_attack():
		return
	return get_power()

func get_power():
	var _r = RandomNumberGenerator.new()
	_r.randomize()
	var n = _r.randi_range(mon_stat.dc,mon_stat.dc_max)

	return n

func get_chance():
	var _ac = mon_stat.ac + mon_stat.ac_max
	var _dc = mon_stat.dc + mon_stat.dc_max
	var _speed_time = mon_stat.atk_speed / 1000
	var _level_speed_mod = mon_stat.level / mon_stat.atk_speed
	var _c2 = _speed_time + _level_speed_mod
	var _c1 = _ac / max(1, _dc) * _c2

	return _c1

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

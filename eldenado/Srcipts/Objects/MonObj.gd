extends Node
class_name MonObj

signal damage(damage)
signal die()

var mon_items:Array = []

var mon_stat:Dictionary = {
	"name":null,
	"level":0,
	"atk_speed":1,
	"dc":0,
	"dc_max":0,
	"ac":0,
	"ac_max":0,
	"hp":0,
	"appr":null,
	"exp":0,
	# following are extra
	"hp_max":0,
	"atk_interval":0,
	"mp":0
} setget set_stat

func get_instance(db:DB, mon_id:String):
	var _mon
	var monster:Node = db.get_data("monster")
	var data:Dictionary = monster.data
	if not data.has(mon_id):
		_mon = null
	var props = data[mon_id]
	var _stat_keys = mon_stat.keys()
	for i in range(props.size()):
		var key = _stat_keys[i]
		if key == "appr":
			mon_stat[key] = "res://Assets/Monsters/Images/{0}.png".format([props[i]])
		else:
			mon_stat[key] = props[i]
	set_drops(db)
	_mon = self
	print("mon instance->",mon_stat)
#	print("test atteck->",attack())

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

func is_dead():
	var dead = false
	if mon_stat.hp <= 0:
		mon_stat.hp = 0
		dead = true
	return dead

func die():
	emit_signal("die")

func give_damage(damage):
	set_stat({
		"hp":mon_stat.hp - damage
	})
	if is_dead():
		die()
	emit_signal("damage", damage)

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

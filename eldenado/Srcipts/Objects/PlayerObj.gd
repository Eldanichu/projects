extends Node
class_name PlayerObj

signal ablity_change()
signal stats_change(stats)
signal damage(value)
signal die()
signal levelup()

const _g:Globals = Globals
const BAG_SIZE:int = 91

var stats:Dictionary = {
	player_name = "",
	class_type = 1,
	gold = 0,
	level = 0,
	hp = 0,
	hp_max = 1,
	mp = 0,
	mp_max = 1,
	expr = 0,
	expr_max = 1,

	# critical strength
	crit_strength = 10,
	# critical chance
	crit_chance = 20,

	# mag = magic spells
	crit_mag_strength = 1.1,
	crit_mag_chance = 40,
	ac = 0,
	ac_max = 0,
	mac = 0,
	mc = 1.0,
	mc_max = 2.0,
	dc = 1.0,
	dc_max = 2.0,
	sc = 1.0,
	sc_max = 2.0
} setget set_stat

var state = Globals.PLAYER_STATE.IDEL

var player_name:String setget ,get_player_name
var equipment := {}
var inventory := {}
var default_attacks := {}
var skill := {}

var disabled:Dictionary = {
	"skill":false,
	"item":false
} setget set_disabled

func setup(_player_info):
	stats.merge(_player_info, true)
	new_player()

func new_player():
	#replace node name to player name
	name = "player_node[{0}]".format([stats.player_name])
	if stats.level == 0:
		stats.gold = 2000
		level_up()

func level_up():
	stats.level = stats.level + 1
	var _class_info = _g.get_class_stats(stats.level,stats.class_type)
	var _exp_value = _g.get_exp_by_level(stats.level)
	stats.hp_max = _class_info["max_hp"]
	stats.mp_max = _class_info["max_mp"]
	stats.hp = 1
	stats.mp = 1
#	stats.hp = stats.hp_max
#	stats.mp = stats.mp_max
	stats.expr = 0
	stats.expr_max = _exp_value

	calculate_stats()
	update_ui_stats()
	emit_signal("levelup")

func update_ui_stats():
	var _stats = {}
	for s in _g.char_display_stat:
		_stats[s] = stats[s]
	emit_stats_change(_stats)

func calculate_stats():
	var _class = stats.class_type
	match _class:
		Globals.CLASS_TYPE.Taos:
			stats.sc_max = stats.sc_max + Globals.taos.sc_base
			stats.sc = stats.sc + Globals.taos.sc_rate
		Globals.CLASS_TYPE.Warrior:
			stats.dc_max = stats.dc_max + Globals.warrior.dc_base
			stats.dc = stats.dc + Globals.warrior.dc_rate
		Globals.CLASS_TYPE.Wizard:
			stats.mc_max = stats.mc_max + Globals.wizard.mc_base
			stats.mc = stats.mc + Globals.wizard.mc_rate

func emit_stats_change(stats:Dictionary):
	var _stats = stats
	emit_signal("stats_change", _stats)

func set_stat(_stat:Dictionary):
	stats.merge(_stat, true)
	emit_stats_change(stats)

func set_disabled(dict:Dictionary):
	disabled.merge(dict, true)
	emit_signal("ablity_change")


func get_player_name():
	return stats.player_name

func is_dead():
	var dead = false
	if stats.hp <= 0:
		stats.hp = 0
		dead = true
	return dead

func can_levelup() -> bool:
	return stats.expr >= stats.expr_max

func die():
	emit_signal("die")
	emit_stats_change(stats)

func revive():
	if not is_dead():
		return
	stats.hp = stats.hp_max
	stats.mp = stats.mp_max

func give_hp(value):
	if stats.hp == stats.hp_max:
		return
	set_stat({
		"hp":min(stats.hp + value, stats.hp_max)
	})

func give_mp(value):
	set_stat({
		"mp":min(stats.mp + value, stats.mp_max)
	})

func give_damge(damage, dmg_type):
	var value = stats.hp - damage
	var rnd := RandomNumberGenerator.new()
	rnd.randomize()
	var _min
	var _max
	if dmg_type == Globals.DAMAGE_TYPE.ATTACK:
		_min = stats.ac
		_max = stats.ac_max
	elif dmg_type == Globals.DAMAGE_TYPE.SPELL:
		_min = stats.mc
		_max = stats.mc_max
	value -= rnd.randi_range(_min,_max)
	set_stat({
		"hp": max(value,0)
	})
	if is_dead():
		die()
		return
	emit_signal("damage", value)

func give_exp(value):
	stats.expr = stats.expr + value
	emit_stats_change(stats)
	if can_levelup():
		level_up()

func give_gold(gold):
	stats.gold = gold + stats.gold

func give_item(item_obj:ItemObject):
	inventory[item_obj._uid] = item_obj
	Event.emit_signal("add_item",item_obj)

func remove_item(item_obj:ItemObject):
	if not item_obj._uid in inventory:
		return
	inventory.erase(item_obj._uid)

func add_skill(skill):
	pass

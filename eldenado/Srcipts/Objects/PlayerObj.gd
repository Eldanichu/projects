extends Node
class_name PlayerObj

signal update_stats(stats)
signal player_died()
signal player_levelup()

const _g = Globals

class AttackPower:
	const _RATE_ATK:float = 2.5
	const _RATE_CRIT_ATK:float = 25.0
	const _NO_DAMAGE_CRIT_MOD = 0.85

	const _MAX_ATK_INC = 0.7
	const _MAX_ATK_DMG_INC = 10

	const _DEFAULT_CRIT = 1.1
	const _MAX_CRIT_ATK_INC = 0
	const _MAX_CRIT_ATK_DMG_INC = 0

	var r := RandomNumberGenerator.new()
	var v_min:int
	var v_max:int
	var _ATK_INC = 0
	var _ATK_DMG_INC = 0
	var _CRIT_ATK_DMG_INC = 0
	var _CRIT_ATK_INC = 0

	var damage:int = 0

	func _init(
		_v_min:int,
		_v_max:int
	) -> void:
		r.randomize()
		v_min = _v_min
		v_max = _v_max

	func cap_value(value):
		return max(0, value)

	func attack() -> bool:
		return is_hit(_RATE_ATK - cap_value(_ATK_INC))

	func crit() -> bool:
		return is_hit(_RATE_CRIT_ATK - cap_value(_CRIT_ATK_INC))

	func atk_damage():
		if !attack():
			return
		var _damge_mod = max(1, cap_value(_ATK_DMG_INC))
		damage = (damage + get_damage()) * _damge_mod

	func no_damage_mod():
		if damage != 0:
			return
		damage = round(v_min * _NO_DAMAGE_CRIT_MOD) + damage

	func crit_damage():
		if crit():
			print("critical")
			no_damage_mod()
			var _crit_mod = _DEFAULT_CRIT + cap_value(_CRIT_ATK_DMG_INC)
			damage = round(damage * _crit_mod)

	func fix_reversed_damage():
		if v_min > v_max:
			v_min = round((v_min - v_max) + 0.5)

	func is_hit(rate:float) -> bool:
		var n = r.randf()
		var _c = 1.0 / (rate * 1.0)
		return n < _c

	func get_damage() -> int:
		fix_reversed_damage()
		var _v = r.randi_range(v_max, v_min)
		return _v

	func calc() -> int:
		atk_damage()
		crit_damage()
		return damage

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
	crit_strength = 1.1,
	# critical chance
	crit_chance = 30,

	# mag = magic spells
	crit_mag_strength = 1.1,
	crit_mag_chance = 40,
	ac = 0,
	ac_mac = 0,
	mc = 0,
	mc_max = 0,
	dc = 0,
	dc_max = 0,
	sc = 0,
	sc_max = 0
} setget set_stat

var equipment := {}
var inventory := {}
var skill := {}

func setup(_player_info):
	stats.merge(_player_info, true)
	new_player()

func new_player():
	if stats.level == 0:
		stats.gold = 2000
		level_up()

func level_up():
	stats.level = stats.level + 1
	var _class_info = _g.get_class_stats(stats.level,stats.class_type)
	var _exp_value = _g.get_exp_by_level(stats.level)
	stats.hp_max = _class_info["max_hp"]
	stats.mp_max = _class_info["max_mp"]
	stats.hp = stats.hp_max
	stats.mp = stats.mp_max
	stats.expr = 0
	stats.expr_max = _exp_value
	var _stats = {}
	for s in _g.char_display_stat:
		_stats[s] = stats[s]
	emit_stats_change(_stats)
	emit_signal("player_levelup")

	#replace node name to player name
	name = "player_node[{0}]".format([stats.player_name])

func emit_stats_change(stats:Dictionary):
	var _stats = stats
	emit_signal("update_stats", _stats)

func set_stat(_stat:Dictionary):
	stats.merge(_stat, true)

func is_dead():
	if stats.hp <= 0:
		stats.hp = 0
		return true
		emit_signal("player_died")
	return false

func take_damage(damages):
	if !is_dead():
		stats.hp = stats.hp - damages
		emit_stats_change({"hp":stats.hp})

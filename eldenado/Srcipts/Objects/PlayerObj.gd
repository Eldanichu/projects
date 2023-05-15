extends Node
class_name PlayerObj

signal stats_change(stats)
signal die()
signal levelup()

const _g:Globals = Globals

class AttackPower:
	const _NO_DAMAGE_CRIT_MOD = 1
	const _DEFAULT_CRIT = 110
	const _MAX_ATK_RATE = 90
	const _MAX_CRIT_ATK_RATE = 80
	const _MAX_ATK_DMG_INC = 500
	const _MAX_CRIT_ATK_DMG_INC = 300

	var r := RandomNumberGenerator.new()
	var v_min:int
	var v_max:int

	var ATK_RATE = 45
	var CRIT_ATK_RATE = 10
	var ATK_RATE_INC = 0
	var ATK_DMG_INC = 0
	var CRIT_ATK_RATE_INC = 0
	var CRIT_ATK_DMG_INC = 0

	var damage:int = 0
	var _is_crit:bool = false

	func _init(
		_v_min:int,
		_v_max:int
	) -> void:
		r.randomize()
		v_min = _v_min
		v_max = _v_max
		_is_crit = false

	func cap(value):
		return max(0, value)

	func attack() -> bool:
		return is_hit(ATK_RATE + ATK_RATE_INC, _MAX_ATK_RATE)

	func crit() -> bool:
		return is_hit(CRIT_ATK_RATE + CRIT_ATK_RATE_INC, _MAX_CRIT_ATK_RATE)

	func atk_damage():
		if !attack():
			return
		var _damge_mod = min(max(1, cap(ATK_DMG_INC)), _MAX_ATK_DMG_INC)
		damage = (damage + get_damage()) * max((_damge_mod / 100), 1)

	func no_damage_mod():
		if damage != 0:
			return
		damage = round(v_min * _NO_DAMAGE_CRIT_MOD) + damage

	func crit_damage():
		if crit():
			print("critical")
			_is_crit = true
			no_damage_mod()
			var _crit_mod = min(_DEFAULT_CRIT + cap(CRIT_ATK_DMG_INC), _MAX_CRIT_ATK_DMG_INC)
			damage = round(damage * max(_crit_mod / 100, 1))

	func fix_reversed_damage():
		if v_min > v_max:
			v_min = round((v_min - v_max) + 0.5)

	func is_hit(rate_min:float, rate_max:float) -> bool:
		var p = min(rate_min / max(rate_max, 1) * 100, rate_max)
		var n = r.randf() * 100 + 1
		var c = (p / 100.0) * 100
		var hit = n < c
		return hit

	func get_damage() -> int:
		fix_reversed_damage()
		var _v = r.randi_range(v_max, v_min)
		return _v

	func is_crit_damage():
		return _is_crit

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
	crit_strength = 10,
	# critical chance
	crit_chance = 20,

	# mag = magic spells
	crit_mag_strength = 1.1,
	crit_mag_chance = 40,
	ac = 0,
	mac = 0,
	mc = 1.0,
	mc_max = 2.0,
	dc = 1.0,
	dc_max = 2.0,
	sc = 1.0,
	sc_max = 2.0
} setget set_stat

var equipment := {}
var inventory := {}
var skill := {}

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
	stats.hp = stats.hp_max
	stats.mp = stats.mp_max
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

func is_dead():
	var dead = false
	if stats.hp <= 0:
		stats.hp = 0
		dead = true
	return dead

func attack():
	var power = AttackPower.new(stats.dc, stats.dc_max);
	power.CRIT_ATK_RATE = stats.crit_chance
	power.CRIT_ATK_DMG_INC = stats.crit_strength
	var dmg = power.calc()
	return [dmg, power.is_crit_damage()]

func take_damage(damages):
	stats.hp = stats.hp - damages
	if is_dead():
			emit_signal("die")
	emit_stats_change(stats)

func give_exp(value):
	stats.expr = stats.expr + value
	emit_stats_change(stats)

func give_gold(gold):
	stats.gold = gold + stats.gold

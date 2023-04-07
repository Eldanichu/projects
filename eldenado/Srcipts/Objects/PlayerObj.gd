extends Node
class_name PlayerObj

signal update_stats(stats)
const _g = Globals

var player_name := ""
var class_type := 1
var gold := 0
var level := 0
var hp := 0
var hp_max := 1
var mp := 0
var mp_max := 1
var expr := 0
var expr_max := 1

# critical strength
var crit_strength = 1.1
# critical chance
var crit_chance = 30

# mag = magic spells
var crit_mag_strength = 1.1
var crit_mag_chance = 40

var ac = 0
var ac_mac = 0
var mc = 0
var mc_max = 0
var dc = 0
var dc_max = 0
var sc = 0
var sc_max = 0

var p := {}

var equipment := {}
var inventory := {}
var skill := {}

func setup(_player_info):
	p = _player_info
	new_player()

func new_player():
	if level == 0:
		update_constants()
		gold = 2000
		level_up()

func level_up():
	level = level + 1
	var _class_info = _g.get_class_stats(level,class_type)
	var _exp_value = _g.get_exp_by_level(level)
	hp_max = _class_info["max_hp"]
	mp_max = _class_info["max_mp"]
	hp = hp_max
	mp = mp_max
	expr = 0
	expr_max = _exp_value
	var stats = {}
	for s in _g.char_display_stat:
		stats[s] = self[s]
	emit_stats_change(stats)

func update_constants():
	class_type = p.class_type
	player_name = p.player_name

	#replace node name to player name
	name = "player_node[{0}]".format([player_name])

func emit_stats_change(stats:Dictionary):
	var _stats = stats
	emit_signal("update_stats",stats)

func is_dead():
	if hp <= 0:
		hp = 0
		return true
	return false

func make_damage(_hp):
	if !is_dead():
		hp = hp - _hp
		emit_stats_change({"hp":hp})

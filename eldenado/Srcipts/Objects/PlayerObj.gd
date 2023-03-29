extends Node
class_name PlayerObj

signal update_stats(stats)

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

var _g = Globals.new()

func setup(player_info):
	if level == 0:
		update_constants(player_info)
		level_up()

func update():
	pass

func level_up():
	level = level + 1
	var _class_info = _g.get_class_stats(level,class_type)
	var _exp_value = _g.get_exp_by_level(level)
	expr_max = _exp_value
	hp_max = _class_info["max_hp"]
	mp_max = _class_info["max_mp"]
	hp = hp_max
	mp = mp_max
	expr = 0
	var stats = [
		hp,
		hp_max,mp,
		mp_max,
		expr,
		expr_max,
		level
	]
	emit_signal("update_stats",stats)

func update_constants(player_info):
	class_type = player_info.class_type
	player_name = player_info.player_name
	name = "player_node[{0}]".format([player_name])

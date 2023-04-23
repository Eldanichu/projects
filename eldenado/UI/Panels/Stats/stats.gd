extends Control
class_name Stats

onready var stats:Dictionary = {
	player_name = $"%player_name",
	class_type = $"%class_type",
	level = $"%lbl_level_value",
	hp = $"%hp",
	mp = $"%mp",
	expr = $"%c_exp"
}

const GLOBAL_VAR = {
	"class_type":"CLASS_NAME"
}

func update_ui(_stat):
	for control in stats:
		var _control = stats[control]
		if _control is Label:
			if control in GLOBAL_VAR:
				var G_VAR = GLOBAL_VAR[control]
				_control.text = Globals[G_VAR][_stat[control]]
			else:
				_control.text = str(_stat[control])

	stats.hp.t_max = _stat.hp_max
	stats.hp.t_val = _stat.hp

	stats.mp.t_max = _stat.mp_max
	stats.mp.t_val = _stat.mp

	stats.expr.t_max = _stat.expr_max
	stats.expr.t_val = _stat.expr

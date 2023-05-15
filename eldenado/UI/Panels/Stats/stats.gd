extends Control
class_name Stats


export(bool) var show_command:bool = false

onready var stats:Dictionary = {
	player_name = $"%player_name",
	class_type = $"%class_type",
	level = $"%lbl_level_value",
	hp = $"%hp",
	mp = $"%mp",
	expr = $"%c_exp"
}

onready var com_panel = $"%command"

const GLOBAL_VAR = {
	"class_type":"CLASS_NAME"
}

func _ready():
	bind_events()

func _process(delta):
	com_panel.visible = show_command

func bind_events():
	var buttons = com_panel.get_children()
	for button in buttons:
		button.connect("pressed",self, "_on_command",[button.name])

func _on_command(type):
	Event.emit_signal("battle_command",type)

func update_ui(_stat):
	stats.player_name.text = _stat.player_name
	stats.class_type.text = Globals.CLASS_NAME[_stat.class_type]
	stats.level.text = str(_stat.level)

	stats.hp.t_max = _stat.hp_max
	stats.hp.t_val = _stat.hp

	stats.mp.t_max = _stat.mp_max
	stats.mp.t_val = _stat.mp

	stats.expr.t_max = _stat.expr_max
	stats.expr.t_val = _stat.expr

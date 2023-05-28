extends Control
class_name Stats, "res://Assets/ui/bars/empty.png"

export(bool) var show_command:bool = false

onready var com_panel := $"%command"
onready var skill_bar := $"%skill_bar"
onready var stats:Dictionary = {
	player_name = $"%player_name",
	class_type = $"%class_type",
	level = $"%lbl_level_value",
	hp = $"%hp",
	mp = $"%mp",
	expr = $"%c_exp"
}

func _ready():
	Event.connect("player_ready",self, "_set_player")
	pass

func _set_player(player:PlayerObj):
	update_ui(player.stats)

func _process(delta):
	com_panel.visible = show_command

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



extends Node2D

onready var u_stats = get_node("%stats")
onready var u_log = get_node("%dlg_log")

func _ready() -> void:
	var ct := CombatText.new("Eldan")
	u_log.println(ct)

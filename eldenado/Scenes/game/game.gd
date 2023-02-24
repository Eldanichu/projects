extends Node2D

onready var u_stats = get_node("%stats")
onready var u_log = get_node("%dlg_log")

func _ready() -> void:
	var ct = CombatText.new()
	ct.append("Hello! {0}".format([ct.color_text("Eldan","#f0f")]))
	u_log.println(ct)
	pass

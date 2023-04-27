extends Control

const GROUP = "skill_slots"

func _ready() -> void:
	setup()
	pass

func setup():
	var slots = get_tree().get_nodes_in_group(GROUP)
	var slot_number = 1
	for s in slots:
		s.slot_key = slot_number
		slot_number = slot_number + 1

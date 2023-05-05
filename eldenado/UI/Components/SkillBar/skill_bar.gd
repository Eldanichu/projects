extends Control

#onready var e_slot := preload("res://11")
#
#const GROUP = "skill_slots"
#const SKILL_BAR_SIZE = 8
#
#func _ready() -> void:
#	setup()
#
#func setup():
#	var slot_number = 1
#	for i in range(SKILL_BAR_SIZE):
#		var s = e_slot.instance()
#		$"%skills".add_child(s)
#		s.slot_key = slot_number
#		slot_number = slot_number + 1

extends Control

onready var combat_log = get_node("%combat_log")
onready var timer = ATimer.new(self)

func _ready():
	pass

func _input(event):
	if event as InputEventMouseButton:
		if event.is_pressed():
			pass

func _on_append_text_pressed() -> void:
	combat_log.println_code_string("")


func _on_Add_Timer_pressed() -> void:
	pass


func _on_reduce_pressed() -> void:
		pass


func _on_Start_Timer_pressed() -> void:
	timer.restart()

func _on_append_item_pressed():
	pass

func _get_random_item():

	pass

func _on_roll_item_pressed():
	pass


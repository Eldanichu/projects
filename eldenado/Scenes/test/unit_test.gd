extends Control

onready var combat_log = get_node("%combat_log")
onready var timer = ATimer.new(self)

func _ready():
	pass

func _input(event):
	if event as InputEventMouseButton:
		if event.is_pressed():
			pass

func _on_Add_Timer_pressed() -> void:
	timer.Interval = 2
	timer.connect("remains",self,"_timer_remaining")
	timer.start_timer()
	pass

func _on_reduce_pressed() -> void:
		pass

func _on_Restart_Timer_pressed() -> void:
	timer.resume()
	pass

func _timer_remaining(s):
	combat_log.println_code_string(str(s))

func _on_pause_timer_pressed() -> void:
	timer.pause()

func _on_append_item_pressed():
	pass


func _on_roll_item_pressed():
	pass

extends Control

onready var combat_log = get_node("%combat_log")
onready var timer = AdjustableTimer.new(self)

func _on_append_text_pressed() -> void:
	var combat_text := CombatTextFormatter.new()
	combat_text.set_formatter(CombatTextFormatter.LogType.MAKE_DAMAGE)
	combat_text.set_text_kv("Monster","32")
	combat_log.println_code_string(combat_text.get_string())
	combat_text.queue_free()


func _on_Add_Timer_pressed() -> void:
	timer.timer_id = 'myTimer-1'
	timer.connect("remains",self,"_on_timer_remaining")
	timer.connect("timeout",self,"_on_timer_remaining")
	timer.start_timer()

func _on_timer_remaining(remains):
	pass

func _on_reduce_pressed() -> void:
	var amount = float(get_node("%amount").text)
	timer.reduce_amount(amount,"%")
	pass # Replace with function body.


func _on_Start_Timer_pressed() -> void:
	timer.restart()
	pass # Replace with function body.

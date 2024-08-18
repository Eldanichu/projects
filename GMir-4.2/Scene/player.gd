extends PlayerObject
class_name PlayerNode


func _ready():
	setup()
	bind_ui_event()

func setup():
	restore_hp()
	update_ui()

func update_ui():
	pass


func bind_ui_event():
	pass

func set_lv_up():
	level_up()
	update_ui()

extends Control

signal start_game()
@onready var start_button = %start_button

func _ready():
	ControlUtil.show_control(self)

func _process(_delta):
	pass

func _on_button_pressed():
	ControlUtil.disable_control(start_button)
	log.d("start game")
	ControlUtil.hide_control(self)
	emit_signal("start_game")

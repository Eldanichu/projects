extends Control

signal start_game()

@onready
var start_button = %start

@onready
var anim = %anim

func _ready():
	ControlUtil.show_control(self)
	modulate.a = 0
	anim.play("fade_in");

func _process(delta):
	pass

func _on_start_pressed():
	ControlUtil.disable_control(start_button)
	print("start game")
	anim.play("fade_out")
	await anim.animation_finished
	ControlUtil.hide_control(self)
	emit_signal("start_game")
	

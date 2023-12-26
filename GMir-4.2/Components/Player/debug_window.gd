extends Window

@export var player:ActorPlayer

@onready var exp_value = %exp_value

@onready var stat_menu = %stat_menu
@onready var stat_slider = %stat_slider

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

func _on_level_up_pressed():
	player.level_up(true)

func _on_set_exp_pressed():
	var value = int(exp_value.text)
	player.set_exp_t(value)


func _on_set_stat_pressed():
	pass # Replace with function body.

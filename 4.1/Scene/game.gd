extends Node2D

@export
var player:PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func add_player():
	var _player = player.instantiate();
	add_child(_player)


func _on_start_menu_start_game():
	add_player()

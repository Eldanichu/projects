extends Node2D

@export
var player:PackedScene

func _ready():
	pass 

func _process(_delta):
	pass

func add_player():
	var _player = player.instantiate();
	add_child(_player)

func _on_start_menu_start_game():
	add_player()

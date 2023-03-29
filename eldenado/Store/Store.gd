extends Node

var player:Player = Player.new()
var game_var:GameVars = GameVars.new()
var settings:Settings = Settings.new()

func free_all():
	queue_free()

func _exit_tree() -> void:
	free_all()

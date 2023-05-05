extends Node

var player:Player = Player.new()
var game_var:GameVars = GameVars.new()
var settings:Settings = Settings.new()

func _exit_tree() -> void:
	queue_free()

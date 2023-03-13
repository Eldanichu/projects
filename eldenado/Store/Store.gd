extends Node

var global:Global = Global.new()
var settings:Settings = Settings.new()
var player:Player = Player.new()

func free_all():
	queue_free()

func _exit_tree() -> void:
	free_all()

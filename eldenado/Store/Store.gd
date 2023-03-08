extends Node

var global:Global = Global.new()
var settings:Settings = Settings.new()
var player:Player = Player.new()

func free_all():
	global.queue_free()
	settings.queue_free()
	player.queue_free()

func _exit_tree() -> void:
	free_all()
	queue_free()

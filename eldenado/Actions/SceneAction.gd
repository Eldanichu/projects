extends Node


onready var splash := $"../game_menu/splash"
onready var start := $"../game_menu/start"
var notice := preload("res://UI/Notification/notice.tscn")


func _ready() -> void:
	pass

func _on_splash_splash_end() -> void:
	start.visible = true
	splash.queue_free()


extends Node


onready var splash := find_node("splash")
onready var start := find_node("start")

func _ready() -> void:

	pass


func _on_splash_splash_end() -> void:
	start.visible = true
	splash.queue_free()

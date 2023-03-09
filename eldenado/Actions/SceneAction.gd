extends Node

var n := Notifer.new(self)
var splash := preload("res://Scenes/splash/splash.tscn")
var game_start := preload("res://Scenes/start/start.tscn")

onready var UI := $"../UI"

func _ready() -> void:
	var _splash := splash.instance()
	UI.add_child(_splash)
	yield(_splash,"splash_end")
	_splash.queue_free()
	start_game()


func start_game():
	var _game_start := game_start.instance()
	_game_start.UI = UI
	UI.add_child(_game_start)

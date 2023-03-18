extends Node

var n := Notifer.new(self)
var splash := preload("res://Scenes/splash/splash.tscn")
var main_menu := preload("res://Scenes/main_menu/main_menu.tscn")
var game := preload("res://Scenes/game/game.tscn")

onready var UI := $"../UI"
onready var MAIN := $".."

func _ready() -> void:
	var _splash := splash.instance()
	UI.add_child(_splash)
	yield(_splash,"splash_end")
	_splash.queue_free()
	start_game()

func start_game():
	var _main_menu := main_menu.instance()
	_main_menu.UI = UI
	UI.add_child(_main_menu)
	Event.connect("create_game",self, "create_game",[_main_menu])

func create_game(res:Dictionary,menu):
	menu.queue_free()
	var _game := game.instance()
	_game.setup(res)
	MAIN.add_child(_game)

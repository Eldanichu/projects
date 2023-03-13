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
	Event.connect("create_game",self, "create_game")

func create_game(res:Dictionary):
	var _success = res["success"]
	if !_success:
		return
	var _game := game.instance()
	MAIN.add_child(_game)
	free_ui()

func free_ui():
	var _main_menu := UI.get_node("main_menu")
	if !_main_menu:
		return
	_main_menu.queue_free()

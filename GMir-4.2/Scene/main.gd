extends Node2D
class_name Main

@onready var game_start = %game_start
@onready var game_menu = %game_menu
@onready var class_menu = %class_menu
@onready var gui = %gui

func _ready():
	game_start.visible = true
	game_menu.visible = false
	gui.visible = false
	
	var clazz = class_menu.get_children()
	for btn in clazz:
		if btn is Button:
			btn.pressed.connect(_on_clazz_select.bind(btn, btn.name))

func _on_clazz_select(btn:Button,btn_name:String):
	var ctype = btn.get_meta(btn_name)
	PlayerData.player_class = ctype
	game_start.visible = false
	game_menu.visible = false
	gui.visible = true

func _on_start_pressed():
	game_start.visible = false
	game_menu.visible = true
	gui.visible = false

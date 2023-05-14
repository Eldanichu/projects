extends Node2D

onready var a_button_pressed := $button_pressed
onready var a_menu_button_pressed := $menu_button_pressed
onready var a_link_pressed := $link_pressed
onready var a_level_up := $level_up

func _ready():
	Event.connect("button_pressed",self,"_on_button_pressed")
	Event.connect("menu_button_pressed",self,"_on_menu_button_pressed")
	Event.connect("link_pressed",self,"_on_link_pressed")
	Event.connect("level_up",self,"_on_level_up")

func _on_button_pressed():
	a_button_pressed.play()

func _on_menu_button_pressed():
	a_menu_button_pressed.play()

func _on_link_pressed():
	a_link_pressed.play()

func _on_level_up():
	if a_level_up.is_playing():
		return
	a_level_up.play()

extends HBoxContainer

var g:G =G.new()

onready var e_bag=$bag
onready var e_charp=$charp

signal display_bag(vis)
signal display_charp(vis)

func _ready() -> void:
	e_bag.connect('pressed',self,'_on_bag_pressed')
	e_charp.connect('pressed',self,'_on_charp_pressed')
	
func _on_bag_pressed()->void:
	emit_signal('display_bag',true)

func _on_charp_pressed()->void:
	emit_signal('display_charp',true)
	
func _exit_tree() -> void:
	g.free()

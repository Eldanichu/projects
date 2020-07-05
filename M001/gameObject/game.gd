extends Node

var L;

func _ready():
	L = Level.new()
	L.init_level()

func _exit_tree():
	L.free()

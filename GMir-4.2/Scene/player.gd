extends Node2D
class_name PlayerNode

@export_category("System")
@export var gui:GUI

var properties:Properties

func _init():
	print("player init")
	properties = Properties.new()
	pass

func _ready():
	print("player ready")
	properties.hp = 100
	gui.set_player(self)
	
	pass
	
func _process(delta):
	pass

func attack():
	properties.hp = properties.hp - 1
	pass

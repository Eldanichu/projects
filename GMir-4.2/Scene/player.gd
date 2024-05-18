extends Node2D
class_name PlayerNode

@export_category("System")
@export var gui:GUI

var properties:Properties = Properties.new()

func _init():
	print("player init")

func _ready():
	print("player ready")
	properties.hp = 100

func attack():
	properties.hp = properties.hp - 1
	pass

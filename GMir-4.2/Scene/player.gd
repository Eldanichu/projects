extends GameObject
class_name PlayerNode

@export_category("System")
@export var gui:GUI



func _init():
	print("player init")

func _ready():
	print("player ready")
	properties.hp = 100
	properties.level = 1
	set_exp(1000)
	gui.update_prop_ui(self)

func attack(target:GameObject):
	
	pass


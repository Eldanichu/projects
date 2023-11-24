extends HBoxContainer
class_name StatItem

@export var data:Dictionary = {}

@onready var prop:Label = %prop
@onready var value:Label = %value

func _ready():
	pass

func _process(delta):
	_update_value()
	pass

func _update_value():
	for key in data:
		if self[key]:
			self[key].text = str(data[key])

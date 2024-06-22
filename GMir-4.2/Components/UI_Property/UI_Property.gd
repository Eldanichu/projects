extends Control
class_name UIProperty
@onready 
var CLabel:Label = %label
@onready 
var CValue:Label = %value

var label:String = "label":
	set(value):
		label = str(value)
		CLabel.call_deferred("set_text",label)
	get:
		return label

var val = "value":
	set(value):
		val = str(value)
		CValue.call_deferred("set_text",val)
	get:
		return val
	
func _ready():
	pass

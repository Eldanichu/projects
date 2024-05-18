extends Control

@onready 
var CLabel:Label = %label
@onready 
var CValue:Label = %value

var label:String = "label":
	set(value):
		label = str(value)
		F.await_tree(
			func():
				CLabel.text = label
		, self)
	get:
		return label

var val = "value":
	set(value):
		val = str(value)
		F.await_tree(
			func():
				CValue.text = val
		, self)
	get:
		return val
	
func _ready():
	pass

extends Control

var rnd = RandomEx.get_instance()


@onready var label: Label = $label

var f1:float = 0
var f2:float = 0.25
var r:int = 0
func _ready():

	pass


func _on_minus_button_up() -> void:
	f1 = f1 + f2
	r = int(f1)
	label.text = str(r)


func _on_plus_button_up() -> void:
	pass # Replace with function body.

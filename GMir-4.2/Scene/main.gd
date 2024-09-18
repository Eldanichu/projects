extends Node2D
class_name Main

@onready var _tree = UNode.new(self)

func _ready() -> void:
	var label:Label = Label.new()
	_tree.add_node("my_label",label)
	_tree.add_node("my_label_1",label.duplicate(8))
	_tree.remove_node("my_label")

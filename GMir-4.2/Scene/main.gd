extends Node2D
class_name Main

@onready var _tree = UNode.new(self)

func _ready() -> void:
	var label:Label = Label.new()
	var n = _tree.add_node("my_label",label)
	_tree.each_node( func(sn, n:Node):n.text = "222" )

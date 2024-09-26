extends Node2D
class_name Main

@onready var _tree = UNode.new(self)

func _ready() -> void:
	#var label:Label = Label.new()
	#var n = _tree.add_node("my_label",label)
	#_tree.each_node( func(sn, n:Node):n.text = "222" )
	var dict = DArray.new()
	dict.push({"dc":20})
	dict.push({"dc":30})
	dict.push({"dc":70})
	print(dict.pop())
	print(dict.shift())
	print(dict.shift())
	print(dict.shift())

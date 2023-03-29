extends Resource
class_name ControlUtil

var node:Control
var initial_mouse_filter:int


func _init(_node:Control) -> void:
	node = _node
	initial_mouse_filter = node.mouse_filter

# Set node to unclickable while in transition.
func unset_clickable():
	node.mouse_filter = Control.MOUSE_FILTER_IGNORE

# Revert initial node clickable value after transition.
func revert_clickable():
	node.mouse_filter = initial_mouse_filter

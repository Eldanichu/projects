extends Control

var label_max_width
var scroll_margin = 100
var coms:Array = []
var current:Label
var com_index = "0"
var reverse = false
func _ready() -> void:
	var first = get_child(0)
	first.name = _get_copy_com_name()
	label_max_width = max(0, first.size.x - size.x) + scroll_margin
	current = first
	coms.append(first)

func _physics_process(delta: float) -> void:
	current.position.x -= 1
	var px = abs(current.position.x)
	if px >= label_max_width - (scroll_margin):
		interchange()
		var _c:Label = current.duplicate(DUPLICATE_USE_INSTANTIATION) as Label
		var _name = _get_copy_com_name()
		_c.name = _name
		if not get_node_or_null(_name):
			coms.append(_c)
			add_child(_c)
			var n = get_node_or_null(_name) as Label
			n.position.x = 0
			current = n
			reverse = !reverse
	var _name = "copy_com1"
	if reverse:
		_name = "copy_com0"
	var next = get_node_or_null("copy_com1") as Label
	if next:
		coms.pop_front()
		var com = get_node_or_null(_name)
		if com:
			remove_child(com)
			
func _get_copy_com_name():
	return "copy_com" + com_index

func interchange():
	if com_index == "0":
		com_index = "1"
	else:
		com_index = "0"

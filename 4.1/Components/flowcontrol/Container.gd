@tool
extends Container

var child_nodes:Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	child_nodes = get_children()
	update_size()
	
func update_size():
	var rect = get_rect()
	var total_width = rect.size.x / len(child_nodes)
	var min_size = get_minimum_size()
	var offset_lt = Vector2(get_offset(SIDE_LEFT),get_offset(SIDE_TOP))
	var point = 0
	var index = 0
	var _w = 0
	for control in child_nodes:
		if index == 0:
			_w = total_width
		_w = total_width - 2
		control.set_size(Vector2(_w, rect.size.y))
		control.set_position(Vector2(point,0))
		point += total_width
		index = index + 1
		pass

func _draw():
	update_size()

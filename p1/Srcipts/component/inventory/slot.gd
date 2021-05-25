extends Control
class_name Slot

signal slot_dbclick;
signal slot_click;

export var index:Vector2 = Vector2(0,0)
export var offset:Vector2 = Vector2(0,0)

const EMPTY_SLOT:Object = null
const WIDTH:float = 37.0
const HEIGHT:float = 38.0
const SIZE:Vector2 = Vector2(WIDTH,HEIGHT)



func _gui_input(event:InputEvent):
	if (event is InputEventMouseButton):
		if (event.button_index == BUTTON_LEFT):
			if event.doubleclick:
				emit_signal("slot_dbclick",index);
			elif event.pressed:
				emit_signal("slot_click",index);

func _process(_delta):
	update();

func _draw() -> void:
	render()

func render() -> void:
	var _position = _index2Postion(index)
	self.name = str(index.x,',',index.y);
	rect_min_size = SIZE;
	rect_position = _position;
	draw_rect(Rect2(index,rect_min_size),Color.white,false)
	
func _index2Postion(index:Vector2) -> Vector2:
	return Vector2(
		WIDTH * index.x + offset.x ,
		HEIGHT * index.y + offset.y
	)

func set_item(item:SlotItem):
	var _childs = get_children();
	if len(_childs):
		for child in _childs:
			child.queue_free();
	add_child(item)

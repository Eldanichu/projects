extends Control
class_name Slot

signal slot_dbclick;
signal slot_click;

export var index:Vector2 = Vector2(0,0);
export var offset:Vector2 = Vector2(0,0);
export var isMouseHover:bool = false;

const EMPTY_SLOT:Object = null;
const WIDTH:float = 37.0;
const HEIGHT:float = 38.0;
const SIZE:Vector2 = Vector2(WIDTH,HEIGHT);


var hover_tip_delay:Timer = Timer.new(); 

func _gui_input(event:InputEvent):
	if event is InputEventMouseMotion:
		display_hover_tip_delay();
	if (event is InputEventMouseButton):
		if (event.button_index == BUTTON_LEFT):
			isMouseHover = false
			if event.doubleclick:
				emit_signal("slot_dbclick",index);
			elif event.pressed:
				emit_signal("slot_click",index);

func display_hover_tip_delay():
	var inventory = get_parent();
	var _tip_timer = inventory.get_node_or_null('hover_tip_delay')
	if _tip_timer:
		return;
	if not _tip_timer:
		inventory.add_child(hover_tip_delay);
		hover_tip_delay.name = 'hover_tip_delay'
		hover_tip_delay.wait_time = 2
	hover_tip_delay.start()
	yield(hover_tip_delay,"timeout")
	if inventory.get_node('hover_tip_delay'):
			inventory.remove_child(hover_tip_delay)
	isMouseHover = true;
	print('display tip')

func _process(_delta):
	update();

func _draw() -> void:
	render()

func render() -> void:
	var _position = _index2Postion(index)
	self.name = str(index.x,',',index.y);
	rect_min_size = SIZE;
	rect_position = _position;
	var _color:Color = Color.white;
	_color.a = .3
	draw_rect(Rect2(index,rect_min_size),_color,false)
	
func _index2Postion(index:Vector2) -> Vector2:
	return Vector2(
		WIDTH * index.x + offset.x ,
		HEIGHT * index.y + offset.y
	)

func get_item():
	if not get_child_count() or not get_child(0):
		return null;
	var _child = get_child(0);
	return _child

func set_item(item:SlotItem):
	var _childs = get_children();
	if len(_childs):
		for child in _childs:
			self.remove_child(child);
			child.queue_free();
	self.add_child(item);
	set_item_center(item);

func set_item_center(item:SlotItem) -> void:
	item.rect_size = SIZE
	item.rect_position = SIZE * .5 - (item.rect_size * .5) 

func _exit_tree():
	queue_free();
	hover_tip_delay.queue_free();

extends TextureRect
class_name Slot

signal slot_dbclick;
signal slot_click;

export(Vector2) var index:Vector2 = Vector2(0,0);
export(Vector2) var offset:Vector2 = Vector2(0,0);

const EMPTY_SLOT:Object = null;
const WIDTH:float = 37.0;
const HEIGHT:float = 38.0;
const SIZE:Vector2 = Vector2(WIDTH,HEIGHT);
const TIP_OFFSET:int = 12

onready var inventory := get_inventory();
onready var tip:Tip = inventory.get_node("Tip");

var MP:Vector2;
var RECT_P:Vector2;
var mouse_slot_index:Vector2;

func _ready() -> void:
	var _position = _index2Postion(index)
	self.name = str(index.x,',',index.y);
	rect_min_size = SIZE;
	rect_position = _position;
	tip.hide();
	var _on_mouse_entered = connect("mouse_entered",self,"_mouse_enter_slot",[index])
	var _on_mouse_exited = connect("mouse_exited",self,"_mouse_exited_slot")

func _mouse_enter_slot(slot_index) -> void:
	var item:ItemObject = get_item();
	if not item:
		return;
	tip.show();
	set_tip_info(item);
	mouse_slot_index = slot_index;

func _mouse_exited_slot() -> void:
	tip.hide();

func set_tip_info(item:ItemObject):
	var info = item.get_item_info();
	tip.Title = info.name;
	tip.Price = str(info.price);

func _gui_input(event:InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.button_index == BUTTON_LEFT):
			if event.doubleclick:
				emit_signal("slot_dbclick",index);
			elif event.pressed:
				emit_signal("slot_click",index);

func _process(_delta) -> void:
	_update_tip_position();
	update();

func _update_tip_position() -> void:
	if not tip.visible: return;
	MP = get_global_mouse_position();
	RECT_P = MP - inventory.rect_position;
	tip.Position = Vector2(RECT_P.x + TIP_OFFSET,RECT_P.y + TIP_OFFSET)
	if is_outside_window().x:
		tip.Position = Vector2(RECT_P.x - tip.rect_size.x + TIP_OFFSET,RECT_P.y + TIP_OFFSET)
	elif is_outside_window().y:
		tip.Position = Vector2(RECT_P.x + TIP_OFFSET,RECT_P.y - tip.rect_size.y + TIP_OFFSET)
	if is_outside_window().x && is_outside_window().y:
		tip.Position = Vector2(RECT_P.x + TIP_OFFSET , RECT_P.y + TIP_OFFSET) - tip.rect_size


func _draw() -> void:
	render()

func render() -> void:
	var _color:Color = Color.white;
	_color.a = .3
	draw_rect(Rect2(index,rect_min_size),_color,false)

func _index2Postion(slot_index:Vector2) -> Vector2:
	return Vector2(
		WIDTH * slot_index.x + offset.x ,
		HEIGHT * slot_index.y + offset.y
	)

func get_item() -> ItemObject:
	if not get_child_count() or not get_child(0):
		return null;
	var _child = get_child(0);
	return _child

func set_item(item:ItemObject) -> void:
	self.remove_item(item);
	self.add_child(item);
	set_item_center(item);

func remove_item(item:ItemObject) -> void:
	var _childs = get_children();
	if not _childs.size():return;
	for child in _childs:
		if item.name == child.name:
			self.remove_child(child);
			child.queue_free();
			tip.hide();

func set_item_center(item:ItemObject) -> void:
	item.rect_size = SIZE
	item.rect_position = SIZE * .5 - (item.rect_size * .5) + index

func get_inventory() -> TextureRect:
	return get_tree().get_nodes_in_group('inventory_root')[0]

func is_outside_window():
	return {
		'x':(RECT_P + MP).x >= OS.get_real_window_size().x,
		'y':(RECT_P + MP).y >= OS.get_real_window_size().y
	}

func _exit_tree() -> void:
	queue_free();

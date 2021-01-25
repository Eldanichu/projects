extends TextureRect
class_name Inventory, "res://Images/ui/inv.png"

signal slot_dbclick(slot_index)

const ROW = 8
const COL = 5
const Y_OFFSET = 59.0
const X_OFFSET = 27.0

const TOTAL_SLOTS = 50
const SLOT_WIDTH = 37.0
const SLOT_HEIGHT = 36.0
const NULL = -4

var SLOT_SIZE =  Vector2(SLOT_WIDTH,SLOT_HEIGHT)
var mouse_pos;
var rect_vector2:Vector2;
var rect_origin_vector2:Vector2;
var dragging = false;

var _font = preload("res://Fonts/sim_sun.tres")
var item_res = preload("res://Images/items.tres")
var current_item;

onready var RECT_SIZE = get_rect().size;
onready var dis = $"."
onready var slots = []
onready var parent_node = get_parent();

func _ready():
	_init_inv_slots();
	set_slot_item(Vector2(0,7),"i29")
	set_slot_item(Vector2(0,6),"i28")
	set_slot_item(Vector2(0,1),"i83")
	set_slot_item(Vector2(4,2),"i394")

func _init_inv_slots():
	var _col = []
	for col_ in range(0,COL):
		_col.append(NULL)
	for row_ in range(0,ROW):
		slots.append(_col.duplicate(true))

func _draw_debug_info():
	draw_string(_font,Vector2(0,-30),"global postion:{0}".format([mouse_pos]),Color.white)
	draw_string(_font,Vector2(0,-56),"rect postion:{0}".format([rect_vector2]),Color.white)
	draw_string(_font,Vector2(0,-116),"rect draggin:{0}".format([dragging]),Color.white)
	draw_string(_font,Vector2(0,-96),"rect_origin postion:{0}, inarea?->{1}".format([rect_origin_vector2,_is_moviable_area()]),Color.white)
	draw_string(_font,Vector2(0,-76),"rect index:{0}".format([_get_slot_index()]),Color.white)

func _process(delta):
	mouse_pos = get_global_mouse_position();
	rect_vector2 = mouse_pos - Vector2(rect_global_position.x + X_OFFSET, rect_global_position.y + Y_OFFSET)
	rect_origin_vector2 = mouse_pos - Vector2(rect_global_position.x, rect_global_position.y)
	_dragging_item()
	update()

func _dragging_item():
	var _item = _get_item_by_name(current_item)
	if(!_item):return
	_item.position = Vector2(mouse_pos.x,mouse_pos.y)

func _draw():
	#_draw_slots();
	#_draw_moviable_area()
	_draw_item();
	_draw_debug_info();
	
	#highlight_slot_index(Vector2(1,1) ,  Color.yellow)
	#_highlight_slot();
	
	"""draw_rect(
				get_rect(),
				Color.white,
				false
			)"""

func add_item(item):
	pass

func set_slot_item(index:Vector2,item):
	if(!_is_inside(Vector2(index.y,index.x))): 
		print_debug("out of index of inventory.")
		return;
	slots[index.y][index.x] = item;

func get_slot_item(index:Vector2):
	if(!_is_inside(Vector2(index.x,index.y))): 
		print_debug("out of index of inventory.")
		return NULL;
	return slots[index.x][index.y];

func highlight_slot_index(index: Vector2, color: Color):
	var slot_pos = _get_slot_position(index)
	if( _is_inside( index ) ):
		draw_rect(Rect2(slot_pos,SLOT_SIZE),color,false);

func _draw_moviable_area():
	var _rect = Rect2(Vector2(0,0),Vector2(RECT_SIZE.x, Y_OFFSET - 3))
	draw_rect(_rect,Color(1,1,1,1),false)

func _is_moviable_area():
	return (
		rect_origin_vector2.x >= 0 && 
		rect_origin_vector2.y >= 0 && 
		rect_origin_vector2.x <= RECT_SIZE.x && 
		rect_origin_vector2.y <= Y_OFFSET - 3
	)

func _draw_slots():
	for col_ in range(0,COL):
		for row_ in range(0,ROW):
			draw_rect(
				Rect2(
					Vector2(
					SLOT_WIDTH * row_ + X_OFFSET,
					SLOT_HEIGHT * col_ + Y_OFFSET
				),
				Vector2(SLOT_WIDTH,SLOT_HEIGHT)
			),
				Color.white,
				false
			)

func _draw_item():
	for col_ in range(0,COL):
		for row_ in range(0,ROW):
			var _vec = Vector2(row_,col_)
			if(_slot_has_item(_vec)):
				var _pos = _get_slot_position(_vec)
				var _item = get_slot_item(_vec);
				if(!item_res[_item]):
					return
				var _item_size = item_res[_item].get_size()
				var _item_pos = Vector2(
					_pos.x + (SLOT_WIDTH *.5) - (_item_size.x *.5),
					_pos.y + (SLOT_HEIGHT *.5) - (_item_size.y *.5)
				)
				draw_texture(item_res[_item],_item_pos)

func _highlight_slot():
	var slot_pos = _get_slot_position(_get_slot_index())
	highlight_slot_index(_get_slot_index() ,  Color.red)

func _is_inside(slot_index:Vector2):
	return (
		slot_index.x >= 0 && 
		slot_index.y >= 0 && 
		slot_index.x < ROW && 
		slot_index.y < COL
	)

func _get_slot_index() -> Vector2:
	return Vector2(
		floor((rect_vector2.x - 0.5) / SLOT_WIDTH),
		floor((rect_vector2.y - 0.5) / SLOT_HEIGHT)
	);

func _get_slot_position(slot_index_vector:Vector2) -> Vector2:
	return Vector2(
		SLOT_WIDTH * slot_index_vector.x + X_OFFSET , 
		SLOT_HEIGHT * slot_index_vector.y + Y_OFFSET
	)

func _slot_has_item(index:Vector2):
	var _slot = slots[index.x][index.y];
	var _slot_type = typeof(_slot);
	
	if(_slot_type == TYPE_STRING):
		return true
	elif (_slot_type == TYPE_INT && _slot == NULL):
		return false
	else:
		print_debug('unknow item in Inventory [{index}]'.format({"index":index}))
		return false

func _input(event):
	#drag_event(event)

	if(event is InputEventMouseButton):
		if(event.button_index == BUTTON_LEFT):
			if(event.pressed):
				var _index = _get_slot_index()
				if(_is_inside(_index)):
					swap_item(_index)
			if(event.doubleclick):
				var _index = _get_slot_index()
				emit_signal("slot_dbclick", _index);

func drag_event(event):
	if event is InputEventMouseMotion:
		if(!_is_moviable_area()):
			dragging = false
	if(_is_moviable_area() && event is InputEventMouseButton):
		if not dragging and event.pressed:
			dragging = true
		if dragging and not event.pressed:
			dragging = false
	if event is InputEventMouseMotion and dragging:
		rect_global_position = event.position - rect_origin_vector2;

func swap_item(index:Vector2):
	var _index = index;
	var _mouse_item;
	var _item = _get_item_by_name(get_slot_item(_index))
	
	if(_item):
		_mouse_item = _item
	else:
		_mouse_item = _get_item_by_name(current_item)

	var _item_pos = Vector2(_index.y,_index.x)
	if(_slot_has_item(_index)):
		if(!_mouse_item):
			var _spr_item = Sprite.new();
			_spr_item.name = get_slot_item(_index);
			_spr_item.texture = item_res[get_slot_item(_index)]
			parent_node.add_child(_spr_item)
			current_item = _spr_item.name
			set_slot_item(_item_pos,NULL)
		else:
			var _temp = get_slot_item(_index)
			set_slot_item(_item_pos,_mouse_item.name)
			_mouse_item.texture = item_res[_temp]
			_mouse_item.name = _temp
			current_item = _mouse_item.name
	elif(!_slot_has_item(_index) && _mouse_item):
		set_slot_item(_item_pos,_mouse_item.name)
		parent_node.remove_child(_mouse_item)

func _get_item_by_name(t_name):
	if(str(t_name) == str(-4)): return false
	var child = parent_node.get_children();
	for c in child:
		if t_name == c.name:
			return c
	return false

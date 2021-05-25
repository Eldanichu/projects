extends TextureRect

const ROW:int = 8
const COL:int = 5
const Y_OFFSET:float = 3.0
const X_OFFSET:float = 4.0

var mouse_pos:Vector2;
var rect_vector2:Vector2;
var rect_origin_vector2:Vector2;
var _item:SlotItem = null setget set_item,get_item;

onready var slots:Array = [];
onready var RECT_SIZE:Vector2 = get_rect().size;


func _ready() -> void:
	_init_inv_slots();

func _process(_delta):
	mouse_pos = get_global_mouse_position();
	rect_vector2 = mouse_pos - Vector2(rect_global_position.x + X_OFFSET, rect_global_position.y + Y_OFFSET);
	rect_origin_vector2 = mouse_pos - Vector2(rect_global_position.x, rect_global_position.y);
	update();

func _init_inv_slots() -> void:
	var _cols = []
	for c in range(0,COL):
		_cols.append(0)
	for r in range(0,ROW):
		slots.append(_cols.duplicate(true))
	_render_slots()

func _render_slots() -> void:
	for col_ in range(0,COL):
		for row_ in range(0,ROW):
			var _slot = Slot.new();
			_slot.index = Vector2(row_,col_);
			_slot.connect("slot_click",self,"_on_slot_click");
			self.add_child(_slot);

func _on_slot_click(p) -> void:
	print(p,get_slot(p),slots[p.x][p.y])
	set_slot(p)

func set_item(item:SlotItem) -> void:
	_item = item

func get_item() -> SlotItem:
	return _item

func get_slot(index:Vector2) -> Slot:
	var _slot:Slot = get_node(str(index.x,',',index.y));
	return _slot;

func set_slot(index:Vector2) -> void:
	var _slot:Slot = get_slot(index)
	if !_slot:
		return
	_slot.set_item(SlotItem.new())




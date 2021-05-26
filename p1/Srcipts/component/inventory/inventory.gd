extends TextureRect

const ROW:int = 8
const COL:int = 5

onready var slots:Array = [];
onready var RECT_SIZE:Vector2 = get_rect().size;


func _ready() -> void:
	_init_inv_slots();
	print(rect_global_position)

func _process(_delta):
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
	set_slot_item(p,SlotItem.new())
	#remove_slot_item(p)
	print(p,get_slot_item(p),slots[p.x][p.y])

func get_slot(index:Vector2) -> Slot:
	var _slot:Slot = get_node(str(index.x,',',index.y));
	return _slot;

func set_slot_item(index:Vector2,item:SlotItem) -> void:
	var _slot:Slot = get_slot(index)
	if get_slot_item(index):
		return
	_slot.set_item(item)

func get_slot_item(index:Vector2) -> SlotItem:
	var _slot:Slot = get_slot(index);
	var _slot_item:SlotItem = _slot.get_item();
	return _slot_item

func remove_slot_item(index:Vector2):
	var _slot:Slot = get_slot(index);
	var _slot_item = get_slot_item(index)
	if not _slot_item:
		print('slot_item does not exists.');
		return
	_slot.remove_item(_slot_item);









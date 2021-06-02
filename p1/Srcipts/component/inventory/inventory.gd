extends TextureRect

const ROW:int = 8
const COL:int = 5

onready var slots:Array = [];
onready var RECT_SIZE:Vector2 = get_rect().size;

var hover_item_data:Dictionary = {}

func _ready() -> void:
	_init_inv_slots();
	_render_slots();

	var item = ItemObject.new()
	item.set_item_info({
		name = 'hp',
		price = '200'
	})
	set_slot_item(Vector2(0,3),item)

	var item2 = ItemObject.new()
	item2.set_item_info({
		name = 'mp',
		price = '230'
	})
	set_slot_item(Vector2(6,4),item2)

func _process(_delta):
	_update_mouse_hover_item();
	update();

func _init_inv_slots() -> void:
	var _cols = []
	for c in COL:
		_cols.append(0)
	for r in ROW:
		slots.append(Common.copy_array_deep(_cols))

func _render_slots() -> void:
	for col_ in COL:
		for row_ in ROW:
			var _slot = Slot.new();
			_slot.index = Vector2(row_,col_);
			self.add_child(_slot);
			_slot.connect("slot_click", self, "_on_slot_click");

func _on_slot_click(slot_index:Vector2) -> void:
	move_and_swap(slot_index)

func move_and_swap(slot_index:Vector2):
	var _item = get_slot_item(slot_index);
	var _hover_item = get_mouse_hover_item();
	if _item:
		if _hover_item:
			# create a tempolary item and save its data.
			var _temp_item = Common.copy_node(_item);
			var _temp_hover_item = ItemObject.new();
			_temp_hover_item.set_item_info(hover_item_data);
			remove_hover_item();

			add_hover_item(_temp_item, slot_index);
			remove_slot_item(slot_index);
			set_slot_item(slot_index, _temp_hover_item);
		else:
			add_hover_item(_item, slot_index);
			remove_slot_item(slot_index);
	elif not _item and _hover_item:
		# create a hovering item instance for setting.
		var _new_hover_item = ItemObject.new();
		_new_hover_item.set_item_info(hover_item_data);
		set_slot_item(slot_index, _new_hover_item);
		remove_hover_item();

func add_hover_item(item,index):
	var ui = get_ui_root();
	item.name = 'mouse_hover_item'
	hover_item_data = get_slot_data(index);
	ui.add_child(Common.copy_node(item));
	item.queue_free();

func remove_hover_item():
	var item = get_mouse_hover_item();
	if not item: return;
	var ui = get_ui_root();
	ui.remove_child(item);
	item.queue_free();

func _update_mouse_hover_item():
	var _hover_item = get_mouse_hover_item();
	if not _hover_item: return;
	_hover_item.rect_position = get_global_mouse_position()

func get_mouse_hover_item():
	var ui = get_ui_root();
	var _hover_item = ui.get_node_or_null("mouse_hover_item");
	return _hover_item

func get_ui_root():
		var _ui_root = get_tree().get_nodes_in_group("ui_root")[0];
		return _ui_root;

func get_slot(index:Vector2) -> Slot:
	var _slot:Slot = get_node(str(index.x,',',index.y));
	return _slot;

func set_slot_item(index:Vector2,item:ItemObject) -> void:
	var _slot:Slot = get_slot(index)
	if not _slot:
		return
	_slot.set_item(item)
	set_slot_data(index,item.get_item_info());

func get_slot_item(index:Vector2) -> ItemObject:
	var _slot:Slot = get_slot(index);
	if not _slot:
		return null;
	var _slot_item:ItemObject = _slot.get_item();
	return _slot_item

func remove_slot_item(index:Vector2):
	var _slot:Slot = get_slot(index);
	var _slot_item = get_slot_item(index)
	if not _slot_item:
		print('slot_item does not exists.');
		return;
	_slot.remove_item(_slot_item);
	remove_slot_data(index);

func get_slot_data(index:Vector2):
	var _slot_data = slots[index.x][index.y];
	return _slot_data;

func set_slot_data(index:Vector2,item_data):
	slots[index.x][index.y] = item_data

func remove_slot_data(index:Vector2):
	slots[index.x][index.y] = 0

extends PanelContainer

onready var grid := $"%item_grid"
onready var gold := $"%gold"
onready var sort_btn := $"%sort"
var bag_slot := preload("res://UI/Components/BasicSlot/basic_slot.tscn")


var player:PlayerObj setget set_player

func _ready() -> void:
	bind_events()

func _process(delta: float) -> void:
	gold.text = str(player.stats.gold)

func setup():
	render_slots()
	render_items()


func bind_events():
	sort_btn.connect("pressed",self,"_on_bag_sort")
	pass

func render_slots():
	var bag_size:int = player.BAG_SIZE
	for i in range(bag_size):
		var _slot:BasicSlot = bag_slot.instance()
		_slot.name = "inv_slot_{0}".format([i])
		_slot.slot_type = Globals.SLOT_TYPE.USEABLE_ITEM
		_slot.connect("pick", self, "_on_bag_slot_pick",[_slot.name])
		_slot.connect("use_item", self, "_on_bag_use_item",[_slot.name])
		grid.add_child(_slot)

func render_items():
	var player_items = player.inventory
	var index = 0

	for item in player_items:
		var o:ItemObject = player_items[item]
		var slot := get_slot_by_index(index)
		slot.set_item(o.to_object())
		index += 1
	pass

func get_slot_by_index(index:int) -> BasicSlot:
	var slots = grid.get_children()
	var _i = min(index, player.BAG_SIZE)
	return slots[_i]

func get_slot_by_id(id:String) -> BasicSlot:
	var slot = grid.get_node_or_null(id)
	return slot

func add_item(item:Dictionary):
	pass

func _on_bag_sort():
	pass

func _on_bag_slot_pick(slot:SlotObject,slot_id):
	print("[inventory](on_pick)->{0}  name: {1}".format([slot,slot_id]))
	var node_mi:MouseFloatItem = GameUtils.get_mouse_item(self)
	var mouse_item = node_mi.item
	var temp:SlotObject = SlotObject.new()
	var _inv_slot := get_slot_by_id(slot_id)
	if !slot.is_empty():
		temp.assign(slot.to_object())
		if has_item(mouse_item):
			_inv_slot.set_item(mouse_item.to_object())
			node_mi.set_item(temp.to_object())
		else:
			_inv_slot.clear()
			node_mi.set_item(temp.to_object())
	else:
		if has_item(mouse_item):
			_inv_slot.set_item(mouse_item.to_object())
			node_mi.clear()
	temp = null

func _on_bag_use_item(slot,slot_id):
	print("[inventory](on_use)->{0}  name: {1}".format([slot,slot_id]))
	if !has_item(slot):
		return
	var item_id = slot.id
	var inv = player.inventory
	if !item_id in inv:
		return
	var item_obj:ItemObject = inv[item_id]
	item_obj.use()


func has_item(slot:SlotObject) -> bool:
	return !slot.is_empty()

func copy(item:Dictionary) -> Dictionary:
	return item.duplicate(true)

func set_player(player_obj:PlayerObj):
	player = player_obj
	if !is_inside_tree():
		return
	if !is_instance_valid(player):
		printerr("[Inventory ]Error: PlayerObject is not found.")
		return
	setup()

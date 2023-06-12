extends PanelContainer

class CustomSorter:
	static func sort_qty(a, b):
		return a["qty"] > b["qty"]

onready var grid := $"%item_grid"
onready var gold := $"%gold"
onready var sort_btn := $"%sort"

var bag_slot := preload("res://UI/Components/BasicSlot/basic_slot.tscn")


var db:DB

var player:PlayerObj setget set_player
func set_player(player_obj:PlayerObj):
	player = player_obj

func _ready() -> void:
	Event.connect("db_ready", self, "setup")
	Event.connect("player_ready",self, "set_player")
	bind_events()

func _process(delta: float) -> void:
	if player:
		gold.text = str(player.stats.gold)

func setup(db_:DB):
	db = db_
	if !is_inside_tree():
		return
	render_slots()
	render_items()

func bind_events():
	sort_btn.connect("pressed",self,"_on_bag_sort")
	Event.connect("add_item",self, "_on_add_item")
	Event.connect("put_item",self, "_on_put_item")
	Event.connect("pick_item",self, "_on_pick_item")

func render_slots():
	var bag_size:int = player.BAG_SIZE
	for i in range(bag_size):
		var _slot:BasicSlot = bag_slot.instance()
		_slot.name = "inv_slot_{0}".format([i])
		_slot.slot.source = Globals.ITEM_SOURCE.INVENTORY
		grid.add_child(_slot)

func render_items():
	var bag_items:Dictionary = player.inventory
	for key in bag_items:
		var item_object:ItemObject = bag_items[key]
		add_item(item_object)

func get_empty_slot() -> BasicSlot:
	var slots:Array = grid.get_children()
	var res:BasicSlot
	for i in range(slots.size()):
		var slot:BasicSlot = slots[i]
		if slot.is_empty():
			res = slot
			break
	return res

func get_slot_by_id(id:String) -> BasicSlot:
	var slot = grid.get_node_or_null(id)
	return slot

func add_item(item_object:ItemObject):
	if !item_object && item_object.exist():
		return
	var slots:Array = grid.get_children()
	var res:BasicSlot
	for i in range(slots.size()):
		var slot:BasicSlot = slots[i]
		var slot_item := slot.get_item()
		if slot_item && slot_item._uid == item_object._uid:
			break
		if !slot_item:
			slot.add_item(item_object)
			break


"""
Events
"""
func _on_bag_sort():
	var inv = player.inventory
	render_items()

func _on_add_item(item_object:ItemObject):
	print("[Inventory](_on_add_item)++++++add item to inv->",item_object.to_object())
	item_object.target = player
	item_object.db = db
	render_items()

func _on_put_item(item_object:ItemObject):
	print("[Inventory](_on_put_item)@@@@@@put item to inv->",item_object.to_object())
	item_object.target = player
	player.give_item(item_object)

func _on_pick_item(item_object:ItemObject):
	print("[Inventory](_on_pick_item)------pick item from inv->",item_object.to_object())
	player.remove_item(item_object)

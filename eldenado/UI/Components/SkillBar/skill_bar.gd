extends HBoxContainer

const SLOT_TYPE = Globals.SLOT_TYPE
const ITEM_SOURCE = Globals.ITEM_SOURCE


onready var active_skills = $"%active_skills"
onready var default_attack = $"%default_attack"

var db:DB
var player:PlayerObj

func _ready() -> void:
	Event.connect("db_ready", self, "setup")
	Event.connect("player_ready",self, "set_player")

func set_player(player_:PlayerObj):
	player = player_

func setup(db_:DB):
	db = db_
	var slot := get_slot_by_id(Globals.SKILL_SLOT.ATTACK)
	if !slot:
		return
	var item = slot.get_skill()
	var _attack := SkillObject.new()
	_attack.id = "default_attack"
	_attack.get_instance()
	slot.add_skill(_attack)

func _process(delta):
	show_bindings()


func _input(event):
	if !player || player.state == Globals.PLAYER_STATE.IDEL:
		return
	if InputUtil.mouse_click(event,BUTTON_LEFT):
		var slot := get_slot_by_id(Globals.SKILL_SLOT.ATTACK)
		if !slot:
			return
		var slot_skill := slot.get_skill()
		var slot_obj := slot.get_instance()
		slot_obj.use_skill()


func get_slot_by_id(id:String) -> BasicSlot:
	var slot = default_attack.get_node_or_null(id)
	return slot

func has_bindings() -> bool:
	if not is_instance_valid(Store) and not "settings" in Store:
		print("Game Store Class is not in AutoLoad.")
		return false
	return true

func get_bindings()->Dictionary:
	if !has_bindings():
		return {}
	var settings = Store.settings
	var _kbs = settings.key_bindings
	return _kbs

func show_bindings():
	var _kbs = get_bindings()
	for o in _kbs:
		if o == "sep":
			continue
		var item:Dictionary = _kbs[o]
		var _slot:BasicSlot = get_slot(o)
		if !_slot:
			continue
		_slot.slot.key = item.key

func update_item(slot_id:String ,item_object:ItemObject):
	var _slot := get_slot(slot_id)
	if item_object.stackable && item_object.size <= 0:
		_slot.clear()
		return
	_slot.set_item(item_object.to_object())

func get_slot(slot_id:String) -> BasicSlot:
	var _slot_node
	var _default_slot = default_attack.get_node_or_null(slot_id)
	var _skill_slot = active_skills.get_node_or_null(slot_id)
	if _default_slot:
		_slot_node = _default_slot
	elif _skill_slot:
		_slot_node = _skill_slot
	return _slot_node

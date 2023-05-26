extends HBoxContainer

onready var active_skills = $"%active_skills"
onready var default_attack = $"%default_attack"

func _ready() -> void:
	setup()

func setup():
	load_key_bindings()

func load_key_bindings():
	if not is_instance_valid(Store) and not "settings" in Store:
		print("Game Store Class is not in AutoLoad.")
		return
	var settings = Store.settings
	var _kbs = settings.key_bindings
	for o in _kbs:
		if o == "sep":
			continue
		var item = _kbs[o]
		var _default:BasicSlot = default_attack.get_node_or_null(o)
		if _default:
			_default.item.assign({
				"key":item.key,
				"from":Globals.ITEM_SOURCE.SKILL_BAR
				})
			_default.connect("use_skill",self,"_on_use_skill")

		var _skills:BasicSlot = active_skills.get_node_or_null(o)
		if _skills:
			_skills.item.assign({
				"key":item.key,
				"from":Globals.ITEM_SOURCE.SKILL_BAR
			})
			_skills.connect("use_skill",self,"_on_use_skill")
			_skills.connect("pick",self,"_on_pick_skill")

func _on_pick_skill(slot:Dictionary):
	print("[skill bar pick ]",slot)
	var node_mouse_item:MouseFloatItem = GameUtils.get_mouse_item(self)
	var mouse_item = node_mouse_item.item
	if !"id" in mouse_item || StringUtil.isEmptyOrNull(mouse_item["id"]):
		return
	var bo_put = Globals.can_slot_put(mouse_item, slot)
	print("[can put in skill bar? ]", bo_put)
	if !bo_put:
		return

func set_slot(attack:AttackObject):
	var _slot_node
	var slot = attack.obj.slot
	var _default_slot = default_attack.get_node_or_null(slot)
	var _skill_slot = active_skills.get_node_or_null(slot)
	if _default_slot:
		_slot_node = _default_slot
	elif _skill_slot:
		_slot_node = _skill_slot
	if !_slot_node:
		return
	var slot_obj:Dictionary = attack.obj
	_slot_node.set_item(slot_obj)

func _on_use_skill(slot_obj:SlotObject):
	Event.emit_signal("player_attack", slot_obj)

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
			_default.set_slot_key(item.key)
			_default.connect("use_skill",self,"_on_use_skill")

		var _skills:BasicSlot = active_skills.get_node_or_null(o)
		if _skills:
			_skills.set_slot_key(item.key)
			_skills.connect("use_skill",self,"_on_use_skill")

func set_slot(attack:AttackBase):
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

func _on_use_skill(slot_obj:Dictionary):
	Event.emit_signal("player_attack", slot_obj)

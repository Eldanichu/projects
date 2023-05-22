extends Control
class_name Stats, "res://Assets/ui/bars/empty.png"

export(bool) var show_command:bool = false

onready var stats:Dictionary = {
	player_name = $"%player_name",
	class_type = $"%class_type",
	level = $"%lbl_level_value",
	hp = $"%hp",
	mp = $"%mp",
	expr = $"%c_exp"
}

onready var com_panel = $"%command"
onready var active_skills = $"%active_skills"
onready var default_attack = $"%default_attack"

const GLOBAL_VAR = {
	"class_type":"CLASS_NAME"
}

func _ready():
	setup()

func _process(delta):
	com_panel.visible = show_command

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

func set_slot(slot:String, attack:AttackBase):
	var _slot_node
	var _default_slot = default_attack.get_node_or_null(slot)
	var _skill_slot = active_skills.get_node_or_null(slot)
	if _default_slot:
		_slot_node = _default_slot
	elif _skill_slot:
		_slot_node = _skill_slot
	if !_slot_node:
		return
	var slot_obj:Dictionary = attack.obj
	slot_obj.merge({"cd":attack.cd},true)
	_slot_node.set_item(slot_obj)

func _on_use_skill(slot_obj:Dictionary):
	Event.emit_signal("player_attack", slot_obj)
	pass

func update_ui(_stat):
	stats.player_name.text = _stat.player_name
	stats.class_type.text = Globals.CLASS_NAME[_stat.class_type]
	stats.level.text = str(_stat.level)

	stats.hp.t_max = _stat.hp_max
	stats.hp.t_val = _stat.hp

	stats.mp.t_max = _stat.mp_max
	stats.mp.t_val = _stat.mp

	stats.expr.t_max = _stat.expr_max
	stats.expr.t_val = _stat.expr

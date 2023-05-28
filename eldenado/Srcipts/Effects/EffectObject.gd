extends Node
class_name EffectObject

onready var timer:ATimer = ATimer.new(self)

var id:String
var target:Node
var count = 0
var amount setget set_amount

var properties:Dictionary = {}

func _init(target_, effect_name, props) -> void:
	id = effect_name
	name = effect_name
	properties = props
	target = target_
	apply()


func _ready() -> void:
	if !amount || amount <= 0:
		_to_player()
		return
	timer.connect("timeout", self, "_on_tick")
	timer.Interval = 1
	timer.start_timer()


func apply():
	if has_buff():
		var method = "buff_{0}_override".format([id])
		if has_method(method):
			var node = target.get_node_or_null(id)
			call(method, node)
		return
	var method = "buff_{0}_props".format([id])
	if has_method(method):
		call(method)
	target.add_child(self)


func has_buff():
	return target.get_node_or_null(id)

func has_target():
	return target != null

func set_amount(value):
	amount = value

func _on_tick():
	if count < amount:
		if self.has_method("_to_monster"):
			call("_to_monster")
		if self.has_method("_to_player"):
			call("_to_player")
		count += 1
		timer.start_timer()
	else:
		count = 0
		properties = {}
		target.remove_child(self)

func _to_player():
	var method = "buff_{0}".format([id])
	if has_method(method):
		call(method,target)

"""
- BUFF EVENTS
"""
# health poition
func buff_healhp(player_obj):
	player_obj.give_hp(properties["step"])
func buff_healhp_props():
	amount = properties["interval"]
func buff_healhp_override(node:Node):
	var _amount = node.amount + properties["interval"]
	node.amount = _amount

# mana poition
func buff_healmp(player_obj):
	player_obj.give_mp(properties["step"])
func buff_healmp_props():
	amount = properties["interval"]
func buff_healmp_override(node:Node):
	var _amount = node.amount + properties["interval"]
	node.amount = _amount

# rejuv poition
func buff_heal_instant(player_obj):
	player_obj.give_mp(properties["mp"])
	player_obj.give_hp(properties["hp"])








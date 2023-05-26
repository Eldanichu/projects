extends Resource
class_name ItemObject

const ITEM_TYPE = Globals.ITEM_TYPE

var _db:DB
var id
var type
var item_type
var icon
var effect_names:Array = []
var effect_object:Array = []
var variables:Dictionary = {}

var properties:Dictionary = {} setget set_properties
var target:Node

var equipment = false
var stackable = false

func _init(options:Dictionary = {}) -> void:
	_db = options.db
	id = options.id
	target = options.target
	variables["size"] = options["size"]
	if variables["size"] > 0:
		stackable = true
	apply_properties()
	apply_effects()

func apply_properties():
	var item = _db.get_data("item")
	var data:Dictionary = item.data
	if not id in data:
		printerr("[ItemObject](apply_properties)-> item is not found in DB.")
		return

	print("[ItemObject](apply_properties)-> instanced item id:",id)
	var item_props:Array = data[id]
	type = Globals.SLOT_TYPE.USEABLE_ITEM
	item_type = item_props[2]
	icon = item_props[3]
	effect_names = item_props[4]

func apply_effects():
	for e in effect_names:
		effect_object.append(EffectObject.new(target, e))

func use():
	for effect in effect_object:
		target.add_child(effect)
	pass

func set_properties(obj:Dictionary):
	equipment = true
	properties.merge(obj, true)

func to_object() -> Dictionary:
	var _props = {
		"id":id,
		"type":type,
		"icon":icon,
	}
	_props.merge(variables)
	return _props

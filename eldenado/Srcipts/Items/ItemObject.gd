extends Resource
class_name ItemObject

const CLASS_NAME = "ItemObject"

const ITEM_TYPE = Globals.ITEM_TYPE
const instance_props:Array = [
	"_uid",
	"id",
	"name",
	"item_type",
	"icon",
	"qty",
	"cd",
	"useable",
	"size",
	"properties",
	"effect_names",
	"equipment",
	"stackable",
]

"""
Item Properties
"""
var _uid:String
var id
var name:String
var item_type
var icon:String
var qty:int
var cd:float = 0.1
var useable:bool = false
var size:int = 0 setget set_size
var properties:Dictionary = {} setget set_properties
var effect_names:Array = []
var pickable:bool = true

var equipment = false
var stackable = false

"""
Private Members
"""
var db:DB setget set_db
var target setget set_target

func _init() -> void:
	_uid = StringUtil.gen_id()
	pass

func set_db(db_):
	db = db_

func set_target(target_):
	target = target_

func get_instance():
	if !db:
		printerr("[ItemObject] DB is not set.")
		return
	var item = db.get_data("item")
	var data:Dictionary = item.data
	if !id:
		printerr("[ItemObject](get_instance)-> id is not defined.")
		return
	if not id in data:
		printerr("[ItemObject](get_instance)-> item is not found in DB.")
		return
	print("[ItemObject](get_instance)-> instanced item id:",id)

	var item_props:Array = data[id]
	qty = item_props[1]
	item_type = item_props[2]

	icon = item_props[3]
	effect_names = item_props[4]
	set_properties(item_props[5])

func apply_effects():
	for effect_name in effect_names:
		EffectObject.new(
			target,
			effect_name,
			properties
		)

func use():
	if Globals.is_use_item(item_type):
		use_item()

func use_item():
	if !useable:
		return
	if !target:
		printerr("target is not set.")
		return
	decrease_size()
	if size <= 0:
		return
	apply_effects()

func set_size(v):
	size = max(0,v)
	stackable = size > 0

func set_properties(obj:Dictionary):
	for key in obj:
		var value = obj[key]
		if key in self:
			self[key] = value
	properties.merge(obj, true)

func increase_size():
	if !stackable:
		return
	size += 1

func decrease_size():
	if !stackable:
		return
	if size <= 0:
		return
	size -= 1

func set_object(obj:Dictionary):
	for key in obj:
		if key in self:
			self[key] = obj[key]

func to_object() -> Dictionary:
	var _props:Dictionary = {}
	for key in instance_props:
		_props[key] = self[key]
	_props.merge(properties, true)
	return _props

func exist():
	return id != null && item_type != null

func remove():
	db = null
	target = null
	id = null
	useable = false
	properties = {}
	effect_names = []
	size = 0
	icon = ""


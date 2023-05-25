extends Resource
class_name ItemObject

var item:Dictionary = {
	"id":"",
	"type":"",
	"icon":null
} setget set_item

var properties:Dictionary = {} setget set_properties
var effects:EffectObject setget set_effect

var equipment = false
var stackable = false

func _init() -> void:
	pass

func use():
	pass

func set_properties(obj:Dictionary):
	equipment = true
	properties.merge(obj, true)

func set_item(obj:Dictionary):
	item.merge(obj, true)
	if ObjectUtil.has_value(obj, "size"):
		if typeof(obj["size"]) == TYPE_INT:
			stackable = true
		else:
			printerr("[ItemObject](set_item) Error: size has to be { int } type")

func set_effect(e:EffectObject):
	effects = e

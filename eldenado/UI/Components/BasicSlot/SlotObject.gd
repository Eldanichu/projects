extends Resource
class_name SlotObject

enum REQUIRED {
	id,
	type,
	icon
}

var id
var type:int
var icon:String
var key
var from
var cd:float
var disabled:bool
var size:int

var variables:Dictionary = {} setget assign, get_variables

func _init() -> void:
	pass

func is_empty():
	var bo = false
	for key in REQUIRED:
		if StringUtil.isEmptyOrNull(self[key]):
			bo = true
	return bo

func to_object() -> Dictionary:
	if is_empty():
		printerr("[SlotObject] to_object()-> required properties {0}".format([REQUIRED]))
		return {}
	var _props = {
		"id":id,
		"type":type,
		"icon":icon,
		"from":from,
		"cd":cd,
		"disabled":disabled
	}
	_props.merge(variables)
	return _props

func assign(dict:Dictionary):
	for key in dict:
		if key in self:
			self[key] = dict[key]
	variables.merge(dict, true)

func get_variables() -> Dictionary:
	return to_object()

func can_use():
	return !disabled

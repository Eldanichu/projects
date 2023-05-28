extends Resource
class_name SlotObject

enum REQUIRED {
	id
}

var id
var type:int
var source:int
var key:String = ""
var disabled:bool


func is_empty():
	var bo = false
	for key in REQUIRED:
		if StringUtil.isEmptyOrNull(self[key]):
			bo = true
	return bo

func to_object() -> Dictionary:
	var _props = {
		"id":id,
		"type":type,
		"disabled":disabled
	}
	if is_empty():
		printerr("[SlotObject] to_object()-> required properties {0}".format([REQUIRED]))
		return {}
	return _props

func assign(dict:Dictionary):
	for key in dict:
		if key in self:
			self[key] = dict[key]

func can_use():
	return !disabled

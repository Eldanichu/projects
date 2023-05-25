extends Reference
class_name ResUtil

const SKILL_PATH = [
	Globals.SLOT_TYPE.SKILL,
	Globals.SLOT_TYPE.SKILL_ITEM
]

const ITEM_PATH = [
	Globals.SLOT_TYPE.EQUIP,
	Globals.SLOT_TYPE.USEABLE_ITEM,
]

static func get_res_image(type, icon:String) -> Texture:
	if StringUtil.isEmptyOrNull(type) || StringUtil.isEmptyOrNull(icon):
		return null
	var res
	var path

	var PATH_TYPE = Globals.PATH_TYPE

	if ITEM_PATH.has(type):
		path = PATH_TYPE[1]
	if SKILL_PATH.has(type):
		path = PATH_TYPE[0]
	res = ResourceLoader.load("res://Assets/{0}/{1}.png".format ( [path, icon ] ) )

	return res

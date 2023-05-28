extends Reference
class_name ResUtil

static func get_res_image(type, icon:String) -> Texture:
	if StringUtil.isEmptyOrNull(type) || StringUtil.isEmptyOrNull(icon):
		return null
	var res
	var path

	var PATH_TYPE = Globals.PATH_TYPE

	if Globals.is_use_item(type):
		path = PATH_TYPE[1]
	if Globals.is_spell(type):
		path = PATH_TYPE[0]
	res = ResourceLoader.load("res://Assets/{0}/{1}.png".format ( [path, icon ] ) )

	return res

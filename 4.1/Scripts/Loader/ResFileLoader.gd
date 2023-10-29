extends Resource
class_name ResFileLoader

class CResLoader:
	var dir:String
	var hnd:DirAccess
	var pwd:String
	var files:PackedStringArray
	
	func _init():
		pass
	
	func set_dir(path:String):
		dir = path
		hnd = DirAccess.open(dir)
		pwd = hnd.get_current_dir()
		files = hnd.get_files()
		return self
	
	# "res://Assets/Tiles/"
	func load_file_ex():
		for f in files:
			var fp = "{0}/{1}".format([pwd,f])
			if f.ends_with(".PNG"):
				var image = Image.load_from_file(fp)
				var texture = ImageTexture.create_from_image(image)
				log.d(texture)

	func load_file_local():
		for f in files:
			if f.ends_with(".import"):
				var config = ConfigFile.new()
				config.load("{0}/{1}".format([pwd,f]))
				var res = ResourceLoader.load(config.get_value("remap","path"))
				var tex = TextureRect.new();
				tex.texture = res

static func get_instance():
	return CResLoader.new()

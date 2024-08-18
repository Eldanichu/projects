extends Control

var rnd = RandomEx.get_instance()

func _ready():

	pass



func _file_selected(path:String):
	async_importer(path)

func async_importer(path):
	var reader = CsvReader.new()
	reader.file_path = path
	reader.open_file()
	var rmon = RESPItem.new()
	rmon.open()
	
	for row in reader.data:
		var item = {
			"NAME":row["Name"],
			"TYPE":row["StdMode"],
			"LEVEL":row["Need"],
			"LEVEL_REQ":row["NeedLevel"],
			"DEF":row["AC2"],
			"AGI":row["AC"],
			"MOD0":row["DC"],
			"MOD1":row["DC2"],
			"LCK":"",
			"ATKSPD":"",
		}
		var type = int(row["StdMode"])
		if  type == 5:
			item["LCK"] = row["AC"]
			item["AGI"] = row["AC2"]
			item["ATKSPD"] = row["MAC2"]
		elif type == 0:
			item["TIME"] = row["MAC2"]
			item["ATK"] = row["AC"]
			item["ELE"] = row["MAC"]
			pass
		rmon.import_item(row["Name"], item)
	rmon.close()

extends Control

var rnd = RandomEx.get_instance()

@onready var gtable: GTable = %gtable

var data = []
var columns = [
	{"title":"c1", "prop":"c1"},
	{"title":"c2", "prop":"c2"},
	{"title":"c2", "type":"button", "prop":"delete&edit"},
]
func _ready():
	gtable.columns = columns
	gtable.row_click.connect(_table_row_click)
	pass

func _table_row_click(index,e):
	print(index, "-->", e)
	data.remove_at(index)
	gtable.reload()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 2:
				var dcr = 100
				data.clear()
				for i in range(1,dcr):
					data.append({"c1":i, "c2":dcr - i,"c3":dcr - i * 0.3})
				gtable.data = data
				gtable.reload()

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


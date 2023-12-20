extends RefCounted
class_name CsvReader

var ignore_header = true
var header_len:int = 0
var file_path:String
var lines:Array = []
var line_keys:Dictionary = {}
var data:Array = []

var pos = 0

func _init():
	data = []
	line_keys = {}
	lines = []
	header_len = 0
	
	
func open_file():
	print(file_path)
	var file = FileAccess.open(file_path,FileAccess.READ)

	while !file.eof_reached():
		var line = file.get_csv_line(",")
		lines.append(line)
	file.close()
	_is_ignore_header()
	parse_body()

func parse_header():
	var header_keys:Array = lines[0]
	header_len = len(header_keys)
	var key
	for i in range(0, len(header_keys) - 1):
		key = header_keys[i]
		line_keys[i] = key

func parse_body():
	var data_len = len(lines)
	var key
	var item
	while pos <= data_len - 1:
		item = lines[pos]
		if len(item) != header_len:
			pos += 1
			continue
		var obj = {}
		for i in line_keys:
			key = line_keys[i]
			obj[key] = item[i]
		data.append(obj)
		pos += 1

func _is_ignore_header():
	if not ignore_header:
		return
	parse_header()
	pos = 1

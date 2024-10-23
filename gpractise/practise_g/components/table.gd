extends Tree
class_name Table

signal button_pressed(row)

@export
var cols := [
	{"label":"name", "prop":"name"},
	{"label":"dc"},
	{"label":"dc1"},
	{"label":"str"},
	{"label":"dex"},
	{"label":"int"},
	{"label":"","button":load("res://assets/icons/01059.png")}
]
@export
var data := []

var _col_size := 0
var _root:TreeItem
var _header:TreeItem
var _rows:Array[TreeItem]


func _ready() -> void:
	_col_size = cols.size()
	hide_root = true
	_root = create_item()
	columns = _col_size
	_init_header()
	button_clicked.connect(_on_tree_button_clicked)
	add_row({"name":"a"})
	add_row({"name":"b"})


func _init_header():
	var i := 0
	_header = create_item(_root)
	for item in cols:
		_header.set_text(i, item["label"])
		i = i + 1

func add_row(obj:Dictionary):
	var _row = create_item(_root)
	_rows.append(_row)
	var keys = obj.keys()
	var i := 0
	for col in cols:
		var _c = col as Dictionary
		var _label = ""
		var _prop = ""
		if _c.has("prop"):
			_prop = _c["prop"]
			if obj.has(_prop):
				_label = obj[_prop]
		if keys.has(_prop):
			_row.set_text(i,_label)
		if _c.has("button"):
			_row.add_button(i,_c["button"])
		i = i + 1

func fill_data():
	for row in data:
		add_row(row)

func dispose(destory:bool = false):
	clear()
	_rows.clear()
	data.clear()
	if not destory:
		_init_header()

func _exit_tree() -> void:
	dispose(true)


func _on_tree_button_clicked(item:TreeItem, column:int, id:int, mouse_button_index:int):
	var i = column - 1
	var o = {}
	for c in range(i, -1,- 1):
		var t = item.get_text(i)
		var _c = cols[i] as Dictionary
		var _prop = ""
		if _c.has("prop"):
			_prop = _c["prop"]
			o[_prop] = t
		i = i - 1
	button_pressed.emit(o)






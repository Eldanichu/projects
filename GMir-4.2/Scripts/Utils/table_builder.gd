extends Node
class_name TableBuilder

var _tree:Tree
var _body:TreeItem;
var _column_size:int = 0
var _col_prop:Dictionary = {}
var _columns:Array = []
var _data:Array = []

func _init(treeNode:Tree):
	_tree = treeNode
	_body = _tree.create_item()
	_tree.hide_root = true
	
func add_row(row:Dictionary):
	var _row = _tree.create_item(_body)
	for col_index in _col_prop:
		var prop = _col_prop[col_index]
		if prop in row:
			var value = str(row[prop])
			_row.set_text(col_index,value)

func set_columns(columns:Array):
	_columns = columns
	_calculate_columns()
	_setup_columns()

func set_data(data:Array):
	_data = data
	_setup_rows()

func _calculate_columns():
	_column_size = len(_columns)
	_tree.columns = _column_size

func _setup_columns():
	var _cols := _columns
	var index = 0
	for col in _cols:
		_tree.set_column_title(index,col["label"])
		_col_prop[index] = col["prop"]
		index = index + 1

func _setup_rows():
	if not _column_size:
		return
	var _rows = _data
	var index = 0
	for _row in _rows:
		add_row(_row)
		index = index + 1

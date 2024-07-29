extends Control
class_name GTable

signal row_click(row_index, ev)

@onready var table_container: ScrollContainer = %table_container
@onready var u_columns: BoxContainer = %columns

"""
Data Item object
{
	[column_key]:column_data_value
}
"""
@export
var data:Array = []
@export
var columns:Array = []

func _ready() -> void:
	reload()

func reload():
	empty()
	for c in columns:
		var tb_name_prefix = "tb_col_{0}".format([c.prop])
		var s_table_column:PackedScene = ResourceLoader.load("res://Components/gtable/gtable_column.tscn") 
		var u_tb_column = s_table_column.instantiate() as GTableColumn
		if "type" in c:
			u_tb_column.type = c.type
		else:
			u_tb_column.type = ""
		if "prop" in c:
			u_tb_column.prop = c.prop
			u_tb_column.name = tb_name_prefix
		if "title" in c:
			u_tb_column.title = c.title
		u_columns.add_child(u_tb_column)
		_set_data_row(tb_name_prefix, c)

func empty():
	var data = u_columns.get_children()
	for item in data:
		u_columns.remove_child(item)
		item.queue_free()

func _set_data_row(tb_col_name, row):
	var col_node = u_columns.get_node_or_null(tb_col_name) as GTableColumn
	col_node.load_data(data)
	if "type" in row:
		var buttons = _get_type_buttons(row.prop)
		for btn_name in buttons:
			col_node.connect(btn_name, _data_row_click)

func _data_row_click(row_index, e):
	emit_signal("row_click", row_index, e)

func _get_type_buttons(prop:String):
	var buttons = prop.split("&")
	return buttons

func _exit_tree() -> void:
	queue_free()



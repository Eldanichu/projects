@tool
extends Control

const u_row = preload("res://DataTablePlugin/row.tscn")

#@onready
#var grid:GridContainer = %grid
#
#@onready
#var grid_header = %grid_header

@onready
var scroll_box = %scrollbox
@onready
var scroll:VScrollBar = %vscroll


var data_load:DataLoad = DataLoad.new()
var data:Array = data_load.loot_data
var results:Array = data.duplicate(true)
var columns_len:int = 1

var box_scroll_height = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_scroll()

#	btn_save.pressed.connect(save_data)
#	setup_header()
#	setup_body()
	pass 

func _process(delta):
	calc_scroll_bar_position()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 4:
			scroll.value = scroll_box.scroll_vertical
			pass
		elif event.button_index == 5:
			scroll.value = scroll_box.scroll_vertical
			pass

func calc_scroll_bar_position():
	scroll.position = Vector2(scroll_box.size.x,scroll_box.position.y)
	scroll.size.y = scroll_box.size.y

func setup_scroll():

	scroll_box.set_deferred("scroll_vertical", 0)
	var child := scroll_box.get_child(0)
	box_scroll_height = child.size.y - scroll_box.size.y
	scroll.max_value = box_scroll_height
	scroll.scrolling.connect(_on_scrolling)
	pass


func _on_scrolling():
	scroll_box.set_deferred("scroll_vertical",scroll.value)
	pass

func setup_header():
	var header_item:Dictionary = data[0]
	var headers:Array = []
	for key in header_item:
		headers.append(key)
#		grid_header.add_child(_h)
	var headers_len = len(headers)
	columns_len = headers_len 

func setup_body():
	var _rows = results
	var _rows_len = len(_rows)
	var item
	for i in range(0,_rows_len - 1):
		item = _rows[i]
		for item_key in item:
			var _row = u_row.instantiate()
			var _text:TextEdit = _row.get_node("text")
			_text.text = str(item[item_key])
			_text.text_changed.connect(Callable(self,"_on_text_changed").bind(i,item,item_key,_text))
#			grid.add_child(_row)

func _on_text_changed(index, item, key, node):
	results[index][key] = node.text
	print(index,"--->",results[index])
	pass

func save_data():
	pass

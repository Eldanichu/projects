extends BoxContainer
class_name GTableColumn

@onready var column_header: Button = %column_header
@onready var column_data: BoxContainer = %column_data

var type:String
var title:String
var prop:String
var width:int
var sortable:bool
var _index = 0

func _ready() -> void:
	pass

func load_data(data:Array):
	empty()
	_set_header()
	_set_signal()
	for item in data:
		_create_date_item_by_type(item)
		_index = _index + 1

func _create_date_item_by_type(item:Dictionary):
	var node:Control
	if not type or type == null:
		node = Label.new()
		node.text = str(item[prop])
		_add_data(node)
	if type == "button":
		var buttons = _get_type_buttons()
		var box = BoxContainer.new()
		box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		box.size_flags_vertical = Control.SIZE_EXPAND_FILL
		for btn_name in buttons:
			node = LinkButton.new()
			node.text = str(btn_name)
			node.pressed.connect(_on_button_click.bindv([btn_name, _index]))
			box.add_child(node)
		_add_data(box)

func _on_button_click(ev_name, index):
	emit_signal(ev_name, index, ev_name)

func _set_header():
	column_header.call_deferred("set_text",title)
func _set_signal():
	if not type:
		return
	var buttons = _get_type_buttons()
	for btn_name in buttons:
		add_user_signal(btn_name)

func _add_data(data_node:Node):
	column_data.add_child(data_node)

func _get_type_buttons():
	var buttons = prop.split("&")
	return buttons

func empty():
	var data = column_data.get_children()
	for item in data:
		column_data.remove_child(item)
		item.queue_free()

func _exit_tree() -> void:
	queue_free()

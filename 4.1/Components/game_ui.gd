extends Control

@export
var player:GamePlayer


@onready
var ui_func_box = %ui_func_box

@onready
var ui_func_buttons = %ui_func_buttons

var current_display_box:String = ""

func _ready():
	hide_all_func_box()
	bind_events()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func hide_all_func_box():
	var ui_func_boxes = ui_func_box.get_children()
	for box in ui_func_boxes:
		ControlUtil.hide_control(box)

func bind_events():
	var _ui_func_buttons = ui_func_buttons.get_children()
	var _button:Button
	for button in _ui_func_buttons:
		_button = button
		_button.pressed.connect(_on_ui_func_button.bind(button.name))

func _on_ui_func_button(type:String):
	var control = ui_func_box.get_node_or_null(current_display_box)
	if control != null:
		ControlUtil.hide_control(control)
	control = ui_func_box.get_node_or_null(type)
	if control == null:
		current_display_box = ""
		return
	if type == current_display_box:
		ControlUtil.hide_control(control)
		current_display_box = ""
	else:
		ControlUtil.show_control(control)
		current_display_box = type

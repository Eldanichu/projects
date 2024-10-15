extends MarginContainer

@onready var body: BoxContainer = %body
@onready var lbl_points: Label = $ScrollContainer/BoxContainer/title/lbl_points

@export_range(4,999)
var points:int = 5

var remains:int:
	set(v):
		remains = v
		set_label_text(lbl_points, remains)

var each_point:Array[int] = []
var total_added:int = 0

var _inc_btns:Array = []
var _dec_btns:Array = []


func _ready() -> void:
	get_dec_buttons()
	get_inc_buttons()
	remains = points
	each_point.resize(remains)
	each_point.fill(0)
	check_button_status()

func body_nodes():
	return body.get_children()

func body_len():
	return body_nodes().size()

func get_dec_buttons():
	var idx = 0
	var children = body_nodes()
	for c in children:
		var box = c as BoxContainer
		var _btn = box.get_node("Button") as Button
		_dec_btns.append(_btn)
		if not _btn.is_connected("pressed",_on_dec_pressed):
			_btn.pressed.connect(_on_dec_pressed.bind(idx))
		idx = idx + 1


func get_inc_buttons():
	var idx = 0
	var children = body_nodes()
	for c in children:
		var box = c as BoxContainer
		var _btn = box.get_node("Button2")
		_inc_btns.append(_btn)
		if not _btn.is_connected("pressed",_on_inc_pressed):
			_btn.pressed.connect(_on_inc_pressed.bind(idx))
		idx = idx + 1

func set_inc_button_disabled(idx:int, disabled:bool = false):
	var btns = _inc_btns
	btns[idx].disabled = disabled

func set_dec_button_disabled(idx:int, disabled:bool = false):
	var btns = _dec_btns
	btns[idx].disabled = disabled

func set_point_value(idx:int, value):
	var children = body_nodes()
	var labels = []
	for c in children:
		var box = c as BoxContainer
		var label = box.get_node("Label")
		labels.append(label)
	set_label_text(labels[idx], str(value))

func set_label_text(label:Label, text):
	if label:
		label.call_deferred("set_text",str(text))

func incable() -> bool:
	var sum = 0
	for i in each_point:
		sum = i + sum
	return sum < points


func _on_dec_pressed(idx:int):
	remains = remains + 1
	each_point[idx] = max(0, each_point[idx] - 1)
	if remains >= points:
		remains = points
	check_button_status()
	
func _on_inc_pressed(idx:int):
	remains = remains - 1
	each_point[idx] = min(points, each_point[idx] + 1)
	if remains <= 0:
		remains = 0
	check_button_status()


func check_button_status():
	inc_button_state()
	dec_button_state()

func inc_button_state():
	var incs = _inc_btns
	var i = 0
	for b in incs:
		set_point_value(i,each_point[i])
		b.disabled = !incable()
		i = i + 1

func dec_button_state():
	var decs = _dec_btns
	var i = 0
	for d in decs:
		var _v = each_point[i]
		set_point_value(i, _v)
		set_dec_button_disabled(i, _v <= 0)
		i = i + 1













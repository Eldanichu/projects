extends MarginContainer

export(String) var title = ""
export(int) var SCROLL_VOL = 10

var scroll_count = 0
var scroll_total = 0
var scroll_tween := Tween.new()

onready var _title := $"%title"
onready var _text := $"%text"
onready var _scroll := $"%scroll_container"


class Properties:
	var node


	func _init(_node):
		node = _node
		pass

	func build():

		pass

func _ready():
	add_child(scroll_tween)


func _input(event):
	if on_scroll_up(event):
		interpolate()
		scroll_count = max(scroll_count - SCROLL_VOL, 0)
		scroll_tween.start()

	if on_scroll_down(event):
		interpolate()
		scroll_count = min(scroll_count + SCROLL_VOL, calc_scroll_total())
		scroll_tween.start()

func interpolate():
	scroll_tween.stop_all()
	scroll_tween.interpolate_method(
		self,
		"scroll_smoth",
		_scroll.scroll_vertical,
		scroll_count,
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT_IN
	)

func on_scroll_up(event):
	if event is InputEventMouseButton:
		return event.button_index == 4

func on_scroll_down(event):
	if event is InputEventMouseButton:
		return event.button_index == 5

func calc_scroll_total():
	var _scroll_h = _scroll.rect_size.y
	var _text_h = _text.rect_size.y
	return _text_h - _scroll_h

func scroll_smoth(e):
	_scroll.scroll_vertical = e


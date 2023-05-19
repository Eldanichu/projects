extends Node
class_name InputUtil

static func _is_mouse_button(e):
	return e as InputEventMouseButton

static func mouse_click(e, button_index):
		if not _is_mouse_button(e):
			return
		return e.is_pressed() && e.button_index == button_index

static func mouse_dbClick(e, button_index):
		if not _is_mouse_button(e):
			return
		return e.doubleclick && e.button_index == button_index

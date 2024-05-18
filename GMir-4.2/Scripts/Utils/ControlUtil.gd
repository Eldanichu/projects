extends Resource
class_name T

func _init():
	pass

static func hide_control(control:Node):
	control.visible = false
	control.mouse_filter = Control.MOUSE_FILTER_IGNORE

static func show_control(control:Node):
	control.visible = true
	control.mouse_filter = Control.MOUSE_FILTER_STOP

static func disable_control(control:Node):
	control.mouse_filter = Control.MOUSE_FILTER_IGNORE

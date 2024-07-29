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

static func set_pause(control:Node,bo:bool):
	control.set_process(bo)
	control.set_physics_process(bo)
	control.set_process_input(bo)
	control.set_process_shortcut_input(bo)
	control.set_process_unhandled_input(bo)
	control.set_process_unhandled_key_input(bo)

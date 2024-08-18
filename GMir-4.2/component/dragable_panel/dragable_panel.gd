extends Control

var sys_font = preload("res://Assets/Fonts/new_system_font.tres")
@onready var panel: Panel = $panel

var hover = false
var hold = false
var win_size:Vector2
var control_size:Rect2
var global_mouse_position:Vector2
var window_position:Vector2
var local_mouse_position:Vector2
var window_mouse_position:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

#func _draw() -> void:
	#draw_string(sys_font,local_mouse_position,str(win_size.y - (global_position.y + size.y)))

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("LMB"):
		hold = false
	moviable(event)

func moviable(event:InputEvent):
	win_size = DisplayServer.window_get_size()
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_LEFT && hover or hold:
			hold = true
			window_mouse_position = event.position - local_mouse_position
			global_position = window_mouse_position
			confine()

func get_edge(axis:String) -> float:
	return win_size[axis] - (global_position[axis] + size[axis] * 2)

func get_edge_size() -> Vector2:
	return Vector2(get_edge("x"), get_edge("y"))

func confine():
	var edge = get_edge_size()
	if global_position.y <= 0:
		global_position.y = 0
	if global_position.x <= 0:
		global_position.x = 0
	if global_position.y >= edge.y:
		global_position.y = edge.y
	if global_position.x >= edge.x:
		global_position.x = edge.x

func _process(delta: float) -> void:
	global_mouse_position = get_global_mouse_position()
	window_position = global_position
	local_mouse_position = global_mouse_position - window_position
	queue_redraw()

func _on_title_mouse_entered() -> void:
	hover = true
func _on_title_mouse_exited() -> void:
	hover = false

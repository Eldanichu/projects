extends MarginContainer

onready var slot_label = $"%label"

var _is_mouse_in = false
var slot_key:int = 1 setget set_slot_key
var skill_id:String

func update():
	slot_label.text = str(slot_key)

func set_slot_key(n):
	slot_key = n
	if is_inside_tree():
		update()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() && _is_mouse_in:
			print(slot_key)


func _on_slot_mouse_entered() -> void:
	_is_mouse_in = true


func _on_slot_mouse_exited() -> void:
	_is_mouse_in = false

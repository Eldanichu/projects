extends MarginContainer
class_name SkillSlot

enum SLOT_ACTION {
	USE = 1,
	MOVE = 2
}

onready var slot_label = $"%label"

var _is_mouse_in = false
var slot_key:int = 0 setget set_slot_key

func _ready() -> void:
	connect("mouse_entered",self,"_on_mouse_in_slot",[true])
	connect("mouse_exited",self,"_on_mouse_in_slot",[false])

func update():
	slot_label.text = str(slot_key)

func set_slot_key(n):
	slot_key = n
	if is_inside_tree():
		update()

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton || !_is_mouse_in:
		return
	if event.button_index == SLOT_ACTION.USE:
		if event.is_pressed():
			print("move item")
		if event.doubleclick:
			print("use item")

func _on_mouse_in_slot(in_out) -> void:
	_is_mouse_in = in_out


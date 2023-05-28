extends CanvasLayer
class_name MouseItem

onready var pitem := $"%item"
onready var p := $"%moveable"

var item:ItemObject setget set_item,get_item
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	visible = exist()

func _input(event):
	if event as InputEventMouseMotion:
		p.position = event.position + Vector2(12,12)

func set_item(item_object:ItemObject) -> void:
	pitem.set_item(item_object)

func get_item() -> ItemObject:
	return pitem.item

func get_object() -> Dictionary:
	if !exist():
		return {}
	return pitem.item.to_object()

func remove():
	if !exist():
		return
	pitem.item.remove()

func exist() -> bool:
	if pitem.item && pitem.item.exist():
		return true
	return false

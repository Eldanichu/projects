extends Node
class_name MouseFloatItem

var item:Dictionary = {
	"id":null,
	"appr":null,
} setget set_item

var texture = TextureRect.new()
var mouse_position:Vector2 = Vector2.ZERO
var position:Vector2 = Vector2.ZERO

func _ready() -> void:
	if !item.id:
		queue_free()
		return
	var root = get_tree().get_root()
	texture.texture = load("res://Assets/Items/00312.png")
	add_child(texture)
	root.add_child(self)

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion:
		return
	if !texture:
		return
	mouse_position = event.position
	texture.rect_position = mouse_position + Vector2(-12, -12)

func _process(delta: float) -> void:
	pass

func set_item(item:Dictionary):
	pass

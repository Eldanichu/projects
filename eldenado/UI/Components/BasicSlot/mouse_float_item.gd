extends Node
class_name MouseFloatItem

var item:Dictionary = {
	"id":"",
	"appr":"",
} setget set_item

var texture = TextureRect.new()
var mouse_position:Vector2 = Vector2.ZERO
var position:Vector2 = Vector2.ZERO

func _ready() -> void:
	var root = get_tree().get_root()
	if !item.id:
		queue_free()
		return

	var res = ResourceLoader.load("res://Assets/Items/{0}.png".format([item.appr]))
	texture.texture = res
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

func set_item(_item:Dictionary):
	if "id" in _item && _item.id != null:
		item.id = _item.id
	if "appr" in _item && _item.appr != null:
		item.appr = _item.appr

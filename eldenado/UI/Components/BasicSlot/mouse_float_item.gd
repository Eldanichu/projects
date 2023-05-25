extends CanvasLayer
class_name MouseFloatItem


var item:Dictionary = {
	"id":"",
	"icon":"",
	"from":"",
} setget set_item

var texture = TextureRect.new()
var mouse_position:Vector2 = Vector2.ZERO
var position:Vector2 = Vector2.ZERO

func _init(node:Node) -> void:
	name = "mouse_item"
	var root = node.get_tree().get_root()
	add_child(texture)
	root.add_child(self)

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion:
		return
	if !texture:
		return
	mouse_position = event.position
	texture.rect_position = mouse_position + Vector2(12, 12)

func _process(delta: float) -> void:
	update_img()
	pass

func update_img():
	if !is_inside_tree() || not "type" in item:
		return
	var res = ResUtil.get_res_image(item.type,item.icon)
	texture.texture = res

func set_item(_item:Dictionary):
	item.merge(_item,true)

func clear():
	set_item({
	"id":"",
	"icon":"",
	"from":"",
})

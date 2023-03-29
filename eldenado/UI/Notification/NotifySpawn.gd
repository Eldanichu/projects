extends Resource
class_name Notifer

var notice := preload("res://UI/Notification/notice.tscn")

var parent_node:Node
var offset := 10
var margin = 10

func _init(node) -> void:
	parent_node = node

func spawn(_msg = "")->void:
	var n = notice.instance()
	n.msg = _msg
	n.y_offset = offset
	update(n)
	parent_node.add_child(n)

func update(n):
	keep_in_screen(n)
	offset = n.rect_size.y + margin + n.y_offset

func keep_in_screen(n):
	var screen_size = OS.get_window_size()
	if offset >= screen_size.y - n.rect_size.y || !has_instance():
		n.y_offset = margin

func has_instance() -> bool:
	var instance := parent_node.get_children()
	var has_notify = false
	for i in range(0,instance.size()):
		var item = instance[i]
		if item.name.match("notify"):
			has_notify = true

	return has_notify

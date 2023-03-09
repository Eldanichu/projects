extends Resource
class_name Notifer

var notice := preload("res://UI/Notification/notice.tscn")

var parent_node:Node
var offset := 10
var margin = 10
var ns := []

func _init(node) -> void:
	parent_node = node

func spawn(_msg = "")->void:
	var n = notice.instance()
	n.msg = _msg
	n.y_offset = offset
	if ns.size() >= 3:
		n.y_offset = margin
		ns.clear()
	offset = n.rect_size.y + margin + n.y_offset
	parent_node.add_child(n)
	ns.append(n)



extends Resource
class_name F

func _init():
	pass

static func await_tree(cb:Callable,node:Node = null):
	if (not cb or cb.is_null() or not cb.is_valid()):
		print_stack()
		return
	cb.bindv([]).call_deferred()

static func add_node_ex(target:Node, node:Node, node_name:String):
	node.name = node_name
	target.add_child(node, true)
	var node_path = NodePath(node_name)
	var _node := target.get_node_or_null(node_path)
	
	return _node

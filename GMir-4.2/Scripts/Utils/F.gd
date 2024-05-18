extends Resource
class_name F

func _init():
	pass

static func await_tree(cb:Callable,node:Node = null):
	if (not cb or cb.is_null() or not cb.is_valid()):
		print_stack()
		return
	if (not node.is_inside_tree()):
		print_stack()
		return
	cb.bindv([]).call_deferred()

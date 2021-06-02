extends Resource
class_name Common

static func copy_node(node:Node):
	return node.duplicate(18)

static func copy_array_deep(array:Array):
	var DEEP = true;
	return array.duplicate(DEEP)


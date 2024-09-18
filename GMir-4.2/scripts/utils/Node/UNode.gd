extends RefCounted
class_name UNode

var tree_nodes:Dictionary = {}

var _get_class_parent_nodearent:Node
func _init(parent:Node) -> void:
	_get_class_parent_nodearent = parent

func add_node(node_name:String, node_obj:Node, parent:Node = null):
	var _node_name = _get_new_node_name(node_name, parent)
	node_obj.name = _node_name
	
	var _parent_node = _get_class_parent_node(parent)
	_parent_node.add_child(node_obj)
	
	var _node_ref = _parent_node.get_node_or_null(_node_name)
	tree_nodes[_node_name] = _node_ref
	return _node_ref

func get_node_ex(node_name:String):
	if node_name in tree_nodes:
		return tree_nodes[node_name]
	return null

func get_nodes() -> Array:
	return tree_nodes.values()

func remove_node(node_name:String,parent:Node = null):
	var _node = get_node_ex(node_name)
	_get_class_parent_node(parent).remove_child(_node)
	tree_nodes.erase(node_name)

func pop_front():
	var nodes = get_nodes()
	if not len(nodes):
		return
	var first = nodes[0]
	remove_node(first.name)

func check_if_duped_node_name(node_name:String, parent:Node = null) -> bool:
	var children:Array = _get_class_parent_node(parent).get_children(true)
	var is_dupe = false
	for node in children:
		if node.name == node_name:
			is_dupe = true
	return is_dupe


func _get_class_parent_node(parent:Node) -> Node:
	var p = parent
	if p == null:
		p = _get_class_parent_nodearent
	return p

func _empty_string(str:String) -> bool:
	return str == "" or str == null

func _get_hash_name(node_name:String) -> String:
	return "{0}_{1}".format([node_name, hash(node_name)])

func _get_new_node_name(node_name:String, parent:Node) -> String:
	var _node_name = node_name
	if _empty_string(_node_name):
		_node_name = ""
	var _parent_node = _get_class_parent_node(parent)
	if check_if_duped_node_name(_node_name, _parent_node):
		_node_name = node_name
	
	return _node_name
	

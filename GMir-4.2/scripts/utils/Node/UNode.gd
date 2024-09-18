extends RefCounted
class_name UNode

var tree_nodes:Dictionary = {}

var _parent:Node
func _init(parent:Node) -> void:
	_parent = parent


func add_node(id:String, node:Node, parent:Node = null):
	if id == "" or id == null:
		return null
	var _node_name = id
	if check_if_duped_node_name(id,_p(parent)):
		_node_name = "{0}_{1}".format([id, hash(id)])
	node.name = _node_name
	node.unique_name_in_owner = true
	_p(parent).add_child(node)
	var _node = _p(parent).get_node_or_null("{0}".format([_node_name]))
	tree_nodes[_node_name] = _node
	return _node

func get_node_ex(node_name:String):
	if node_name in tree_nodes:
		return tree_nodes[node_name]
	return null

func get_nodes() -> Array:
	return tree_nodes.values()

func remove_node( id:String,parent:Node = null):
	var _node = get_node_ex(id)
	_p(parent).remove_child(_node)
	tree_nodes.erase(id)

func pop_front():
	var nodes = get_nodes()
	if not len(nodes):
		return
	var first = nodes[0]
	remove_node(first.name)

func check_if_duped_node_name(node_name:String, parent:Node) -> bool:
	var children:Array = _p(parent).get_children(true)
	var is_dupe = false
	for node in children:
		if node.name == node_name:
			is_dupe = true
	return is_dupe


func _p(parent:Node) -> Node:
	var p = parent
	if p == null:
		p = _parent
	return p

extends RefCounted
class_name UNode

var uid = ResourceUID
var _parent:Node
var _nodes:Dictionary = {}

func p(n:Node):
	_parent = n

func _init(parent:Node) -> void:
	_parent = parent

func add_node(node_name:String, node_obj:Node, parent:Node = null):
	var node_id = _node_id(node_name)
	print("added node id->  ",node_id)
	node_obj.name = node_id
	_u_get_parent(parent).add_child(node_obj)
	return get_node_u(node_name)
	
func get_node_u(node_name:String, parent:Node = null):
	var _p_node = _u_get_parent(parent)
	var _node_ref
	if node_name in _nodes:
		_node_ref = _nodes[node_name]
	else:
		_node_ref = node_name
	var _node_obj = _p_node.get_node_or_null(_node_ref)
	return _node_obj

func remove_node(node_name:String, parent:Node = null):
	var _node_obj = get_node_u(node_name,parent)
	var _p_node = _u_get_parent(parent)
	if not _node_obj:
		return
	_p_node.remove_child(_node_obj)
	_node_obj.queue_free()

func get_nodes(parent:Node):
	var node_data:Array = []
	for _node_name in _nodes:
		var _n = get_node_u(_node_name)
		node_data.append(_n)
	return node_data

func each_node(cb:Callable, parent:Node = null):
	var nodes = get_nodes(parent)
	var nodes_len = len(nodes)
	for i in range(nodes_len - 1,-1,-1):
		var node = nodes[i]
		var nid = uid.get_id_path(StringName(node.name).to_int())
		var nname = _nodes[str(nid)]
		cb.bindv([nid,node]).call()

func _node_id(node_name:String) -> String:
	var id = uid.create_id()
	uid.add_id(id, node_name)
	var path = uid.get_id_path(id)
	print("node added to uid:->", id, "| uid->name = ",uid.get_id_path(id))
	var id_str = str(id)
	_nodes[path] = id_str
	return id_str

func _u_get_parent(parent:Node):
	if parent != null:
		return parent
	return _parent

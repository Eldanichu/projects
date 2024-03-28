extends Control
class_name GUI

var _player:PlayerNode

var prop_nodes:Dictionary = {}

func _ready():
	
	pass

func set_player(player:PlayerNode):
	_player = player
	cache_property_nodes()
	update_ui()

func cache_property_nodes():
	var props = _player.properties.prop
	var prop_node:Label
	for key in props:
		prop_node = get_node_or_null("%value_{0}".format([key]))
		if not prop_node:
			continue
		prop_nodes[key] = prop_node

func update_properties():
	var props = _player.properties.prop
	var lbl:Label
	for key in props:
		if key in prop_nodes:
			lbl = prop_nodes[key]
			lbl.text = str(props[key])

func player_attack():
	_player.attack()
	update_ui()

func update_ui():
	update_properties()
	pass





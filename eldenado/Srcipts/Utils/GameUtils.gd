extends Resource
class_name GameUtils

static func get_percent(value:float,max_value:float) -> float:
	var b_value:BigNumber = BigNumber.new(str(value))
	var b_max_value:BigNumber = BigNumber.new(str(max_value))

	if(b_max_value.isEqualTo(0)):
		max_value = 1.0
	b_max_value = BigNumber.new(str(max_value))

	var percent = b_value.divide(b_max_value).toFloat()
	return percent * 100

static func set_label_text(value:String,max_value:String, percent:String = "") -> String:
	var b_value:BigNumber = BigNumber.new(value,1)
	var b_max_value:BigNumber = BigNumber.new(max_value,1)
	var s_text_format = ("{value} / {max_value}")
	var oFormat:Dictionary = {}

	if(percent and percent != ""):
		s_text_format = ("{value} / {max_value}  {percent}%")
		oFormat["percent"] = percent

	if(b_value.isLargerThanOrEqualTo(b_max_value)):
		value = max_value
	if(b_value.isLessThanOrEqualTo(0)):
		value = "0"
	b_value = BigNumber.new(value)
	b_max_value = BigNumber.new(max_value)

	var text
#	if(Store.settings.useShortNumber):
#		oFormat["value"] = str(b_value.toAA())
#		oFormat["max_value"]=str(b_max_value.toAA())
#		text = s_text_format.format(oFormat)
#	else:
	oFormat["value"] = str(b_value.toString())
	oFormat["max_value"]=str(b_max_value.toString())
	text = s_text_format.format(oFormat)
	return text

static func set_z_index(control_node:CanvasItem,z_index:int):
	VisualServer.canvas_item_set_z_index(control_node.get_canvas_item(),z_index)

static func quit(node:Node):
	node.get_tree().quit()

func get_mouse_item(node):
	var mouse_item = get_root_node(node,"mouse_item")
	return mouse_item

static func get_root_node(node:Node,node_name:String):
	var tree:SceneTree
	if node.has_method("get_tree"):
		tree = node.get_tree()
	if tree == null:
		return null
	return tree.get_root().get_node_or_null(node_name)

static func get_main_node(node,node_name):
	var main = get_root_node(node, "main")
	if !main:
		return null
	var _node = main.get_node_or_null(node_name)

static func get_game_node(node,node_name):
	var main = get_root_node(node, "main")
	if !main:
		return
	var game = main.get_node_or_null("game")
	var _node = game.get_node_or_null(node_name)

	return _node

static func get_player(node,player_name):
	var player = get_game_node(node, "player_node[{0}]".format([player_name]))

	return player

static func get_db(node):
	var _db = get_game_node(node,"DB")
	
	return _db

extends Node
class_name DB

signal db_ready()

onready var root = get_tree().get_root()

var count = 0

func _ready() -> void:
	name = "DB"
	setup()

func setup():
	print("loding..DB")
	var data:Dictionary = {
		"map":ResourceLoader.load_interactive("res://DB/MapData.gd"),
		"item":ResourceLoader.load_interactive("res://DB/Items.gd"),
		"drop_item":ResourceLoader.load_interactive("res://DB/DropItem.gd"),
		"monster":ResourceLoader.load_interactive("res://DB/Monster.gd"),
		"monster_group":ResourceLoader.load_interactive("res://DB/MonsterGroup.gd"),
	}

	var data_keys:Array = data.keys()
	var data_counts = data_keys.size()

	for o in data_keys:
		var res = data[o]
		if res.poll() == 18 && res.has_method("get_resource"):
			count = count + 1
			var src = res.get_resource()
			if src.has_method("new"):
				var _node = src.new()
				_node.name = o
				add_child(_node)

	emit_signal("db_ready")

func get_data(node_id:String):
	var _node = get_node(node_id)
	return _node

func get_data_collection(data:Dictionary):
	var _data = data
	var keys = _data.keys()
	var res = []
	for k in keys:
		var item:Array = _data[k]
		item.append(k)
		res.append(_data[k])
	return res

extends GridContainer
class_name Stats

const stat_item = preload("res://Components/stat_item.tscn")
const u_stats_name_prefix = "stat_item?"

@export
var actor:GameActor:
	set(value):
		actor = value
		update_stats_ui()

@onready
var u_stats = %stats

var actor_stats = Enums.PLAYER_EXCLUSIVE_STATS
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_stats_ui():
	if not is_inside_tree():
		return
	var res
	var node_name
	var item
	var _stat_item
	for s in actor_stats:
		_stat_item = stat_item.instantiate()
		node_name = "{0}{1}".format([u_stats_name_prefix,s])
		item = u_stats.get_node_or_null(node_name)
		_stat_item.name = node_name
		_stat_item.stat_value = actor.stats[actor_stats[s]]
		
		if item:
			item.stat_value = actor.stats[actor_stats[s]]
		else:
			u_stats.add_child(_stat_item)

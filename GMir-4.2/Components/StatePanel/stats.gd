extends Control
class_name Stats

var player_obj:ActorPlayer

const PREFIX_NAME = "SI_"

func _ready():

	pass

func update_stats_ui():
	if not player_obj:
		return
	var _player_stats = player_obj.stats.get_properties()
	
	for key in _player_stats:
		var node_name = "{prefix}{key}".format({
			"prefix":PREFIX_NAME,
			"key":key
		})

		var node:StatItem = find_child(node_name, true)

		if not node:
			continue
		node.data = {
			"prop" : key + ":",
			"value": _player_stats[key]
		}



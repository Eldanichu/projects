extends Control
class_name Stats

var player_scene:GamePlayer

const PREFIX_NAME = "SI_"

func _ready():
	S.stats_changed.connect(update_stats_ui)
	pass

func update_stats_ui():
	if not player_scene:
		return
	var _player_stats = player_scene.player.stats.get_properties()
	
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



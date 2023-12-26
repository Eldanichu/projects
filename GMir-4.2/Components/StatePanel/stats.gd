extends Control
class_name StatPage

var player:ActorPlayer

const PREFIX_NAME = "SI_"

func _ready():
	pass

func initialize():
	if not player:
		return
	player.stats_change.connect(update, CONNECT_REFERENCE_COUNTED)
	player.stats_change.emit()

func update():
	if not player:
		return
	var _player_stats = player.stats.get_properties()
	
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



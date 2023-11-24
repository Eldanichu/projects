extends Control
class_name Stats

@export var player:GamePlayer:
	set(_player):
		player = _player
		if not player:
			return
		bind_event()

const PREFIX_NAME = "SI_"

func _ready():
	
	pass

func bind_event():
	player.actor.secondary_stats.add_event(update_stats_ui,"p1")

func update_stats_ui(changes):
	if not player:
		return
	var _player_stats = player.actor.secondary_stats.get_properties()
	
	for key in _player_stats:
		var node_name = "{prefix}{key}".format({
			"prefix":PREFIX_NAME,
			"key":key
		})

		var node:StatItem = find_child(node_name, true)
		if not node:
			return
		node.data = {
			"prop" : key + ":",
			"value": _player_stats[key]
		}



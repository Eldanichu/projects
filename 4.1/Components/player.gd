extends Node2D

const stat_item = preload("res://Components/stat_item.tscn")
const sep = preload("res://Components/h_separator.tscn")
const u_stats_name_prefix = "stat_item?"

var actor = GameActor.new()
var actor_stats = Enums.PLAYER_EXCLUSIVE_STATS


@onready
var u_stats = %col_0

func _ready():
	update_stats()
	update_stats_value()

func _process(delta):
	update_stats_value()

func update_stats():
	for s in actor_stats:
		if actor_stats[s] == actor_stats.LINE_SPLIT:
			u_stats = get_node("%col_1")
			continue
		var path:String = IconLoader.ICON_STATS[actor_stats[s]]
		var res
		var meta
		if path.contains("#r"):
			res = load(path.replace("#r",""))
			meta = res.get_meta("rColor")
		else:
			res = load(path)
		var _stat_item = stat_item.instantiate()
		_stat_item.name = "{0}{1}".format([u_stats_name_prefix,s])
		_stat_item.icon = res
		if meta:
			_stat_item.color = (meta)
		
		u_stats.add_child(_stat_item)

func update_stats_value():
	if not len(actor_stats):
		return
	var item
	for s in actor_stats:
		item = u_stats.get_node("{0}{1}".format([u_stats_name_prefix,s]))
		if item == null:
			continue
		item.stat_value = actor.stats[actor_stats[s]]

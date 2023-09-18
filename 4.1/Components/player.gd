extends Node2D

const stat_item = preload("res://Components/stat_item.tscn")
const sep = preload("res://Components/h_separator.tscn")
const u_stats_name_prefix = "stat_item?"

var actor = GameActor.new()
var actor_stats = Enums.PLAYER_EXCLUSIVE_STATS


@onready
var u_stats = %col_0

@onready
var hp_bar:TweenProgress = %hp_bar
@onready
var mp_bar:TweenProgress = %mp_bar

@onready
var hp_value:Label = %hp_value
@onready
var mp_value:Label = %mp_value

func _ready():
	update_actor_stats()
	update_stats()
	update_stats_value()

func _process(delta):
	update_stats_value()
	pass

func update_stats():
	for s in actor_stats:
		if actor_stats[s] == actor_stats.LINE_SPLIT:
			u_stats = get_node_or_null("%col_1")
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
		var node_name = "{0}{1}".format([u_stats_name_prefix,s])
		u_stats = get_node_or_null("%col_0")
		item = u_stats.get_node_or_null(node_name)
		if item == null:
			u_stats = get_node_or_null("%col_1")
			item = u_stats.get_node_or_null(node_name)
		if item:
			item.stat_value = actor.stats[actor_stats[s]]

func update_actor_stats():
	var ms = actor.main_stats
	hp_bar.v_max = ms[Enums.PLAYER_PRIMARY_STATS.HP]
	hp_bar.v_min = ms[Enums.PLAYER_PRIMARY_STATS.HPMAX]
	mp_bar.v_max = ms[Enums.PLAYER_PRIMARY_STATS.MP]
	mp_bar.v_min = ms[Enums.PLAYER_PRIMARY_STATS.MPMAX]
	hp_value.text = "{0}/{1}".format([hp_bar.v_min,hp_bar.v_max])
	mp_value.text = "{0}/{1}".format([mp_bar.v_min,mp_bar.v_max])

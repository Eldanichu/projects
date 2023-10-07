extends Node2D
class_name GamePlayer

const stat_item = preload("res://Components/stat_item.tscn")
const sep = preload("res://Components/h_separator.tscn")
const u_stats_name_prefix = "stat_item?"

var actor:GameActor
var actor_stats = Enums.PLAYER_EXCLUSIVE_STATS

@onready
var u_stats = %stats_grid
@onready
var hp_bar:TweenProgress = %hp_bar
@onready
var mp_bar:TweenProgress = %mp_bar
@onready
var hp_value:Label = %hp_value
@onready
var mp_value:Label = %mp_value

func _ready():
	bind_event()
	setup()
	
func _process(_delta):
	pass

func setup():
	Log.d(setup)
	actor = GameActor.new()
	actor.emit_stats_change()

func bind_event():
	PlayerEvent.stats_change.connect(update_ui)

func update_stats_ui():
	var res
	var node_name
	var item
	var _stat_item
	for s in actor_stats:
		res = IconLoader.get_resource(actor_stats[s])
		_stat_item = stat_item.instantiate()
		node_name = "{0}{1}".format([u_stats_name_prefix,s])
		item = u_stats.get_node_or_null(node_name)
		_stat_item.name = node_name
		_stat_item.icon = res.icon
		_stat_item.color = res.meta
		_stat_item.stat_value = actor.stats[actor_stats[s]]
		
		if item:
			item.stat_value = actor.stats[actor_stats[s]]
		else:
			u_stats.add_child(_stat_item)

func update_ui():
	update_stats_ui()
	hp_bar.v_max = actor.get_hp(false, true)
	hp_bar.v_min = actor.get_hp(false, false)
	mp_bar.v_max = actor.get_mp(false, true)
	mp_bar.v_min = actor.get_mp(false, false)
	hp_value.text = actor.get_hp(true)
	mp_value.text = actor.get_mp(true)

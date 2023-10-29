extends Node2D
class_name GamePlayer

var actor:GameActor

@onready
var game_ui = %game_ui
@onready
var stats:Stats = game_ui.get_node("%stats")
@onready
var hp_bar:TweenProgress = game_ui.get_node("%hp_bar")
@onready
var mp_bar:TweenProgress = game_ui.get_node("%mp_bar")
@onready
var hp_value:Label = game_ui.get_node("%hp_value")
@onready
var mp_value:Label = game_ui.get_node("%mp_value")

func _ready():
	
	bind_event()
	setup()
	
func _process(_delta):
	pass

func setup():
	game_ui.player = self
	actor = GameActor.new()
	actor.emit_stats_change()

func bind_event():
	PlayerEvent.stats_change.connect(update_ui)

func update_ui():
	stats.actor = actor
	hp_bar.v_max = actor.get_hp(false, true)
	hp_bar.v_min = actor.get_hp(false, false)
	mp_bar.v_max = actor.get_mp(false, true)
	mp_bar.v_min = actor.get_mp(false, false)
	hp_value.text = actor.get_hp(true)
	mp_value.text = actor.get_mp(true)

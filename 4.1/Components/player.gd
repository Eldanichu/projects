extends Node2D
class_name GamePlayer

var actor:GameActor

@onready
var stats:Stats = %stats
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

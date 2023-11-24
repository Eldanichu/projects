extends VBoxContainer
class_name CharStat

@export var player:GamePlayer:
	set(_player):
		player = _player
		if not player:
			return
		bind_event()

@onready var hp_bar:TweenProgress = get_node("%hp_bar")
@onready var mp_bar:TweenProgress = get_node("%mp_bar")
@onready var hp_value:Label = get_node("%hp_value")
@onready var mp_value:Label = get_node("%mp_value")

@onready var exp_bar = %exp_bar
@onready var lvl = %lvl

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func bind_event():
	player.actor.primary_stats.add_event(update, "p0")

func update(changed):
	var actor = player.actor
	hp_bar.v_max = actor.get_hp(false, true)
	hp_bar.v_min = actor.get_hp(false, false)
	mp_bar.v_max = actor.get_mp(false, true)
	mp_bar.v_min = actor.get_mp(false, false)
	hp_value.text = actor.get_hp(true)
	mp_value.text = actor.get_mp(true)
	exp_bar.v_max = actor.primary_stats.EXPMAX
	exp_bar.v_min = actor.primary_stats.EXP
	lvl.text = "Lv: {0} ".format([str(actor.primary_stats.LEVEL)])

extends VBoxContainer
class_name CharStat

var player_obj:ActorPlayer
var on_battle:bool = false

@onready var hp_bar :TimerProgress = get_node("%hp_bar")
@onready var mp_bar:TimerProgress = get_node("%mp_bar")
@onready var hp_value:Label = get_node("%hp_value")
@onready var mp_value:Label = get_node("%mp_value")

@onready var exp_bar = %exp_bar
@onready var lvl = %lvl

@onready var battle_control = %battle_control

func _ready():
	pass

func bind_event():
	if not player_obj:
		return
	battle_control.visible = on_battle
	player_obj.stats_change.connect(update)
	
func update():
	var actor = player_obj
	hp_bar.v_max = actor.get_hp(false, true)
	hp_bar.v_min = actor.get_hp(false, false)
	mp_bar.v_max = actor.get_mp(false, true)
	mp_bar.v_min = actor.get_mp(false, false)
	hp_value.text = actor.get_hp(true)
	mp_value.text = actor.get_mp(true)
	exp_bar.v_max = actor.stats.EXPMAX
	exp_bar.v_min = actor.stats.EXP
	lvl.text = "Lv: {0} ".format([str(actor.stats.LEVEL)])

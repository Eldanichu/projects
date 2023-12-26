extends VBoxContainer
class_name CharStat

var player:ActorPlayer
var battle_options:bool = false

@onready var hp_bar :TimerProgress = get_node("%hp_bar")
@onready var mp_bar:TimerProgress = get_node("%mp_bar")
@onready var hp_value:Label = get_node("%hp_value")
@onready var mp_value:Label = get_node("%mp_value")

@onready var exp_bar = %exp_bar
@onready var lvl = %lvl

@onready var battle_control = %battle_control

func _ready():
	pass

func initialize():
	if not player:
		return
	battle_control.visible = battle_options
	player.stats_change.connect(update, CONNECT_REFERENCE_COUNTED)
	player.stats_change.emit()
	
func update():
	var actor = player
	hp_bar.v_max = actor.get_hp(false, true)
	hp_bar.v_min = actor.get_hp(false, false)
	mp_bar.v_max = actor.get_mp(false, true)
	mp_bar.v_min = actor.get_mp(false, false)
	hp_value.text = actor.get_hp(true)
	mp_value.text = actor.get_mp(true)
	exp_bar.v_max = actor.stats.EXPMAX
	exp_bar.v_min = actor.stats.EXP
	lvl.text = "Lv: {0} ".format([str(actor.stats.LEVEL)])

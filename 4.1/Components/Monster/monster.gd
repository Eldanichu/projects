extends Node
class_name Monster

@onready var m_name = %m_name
@onready var m_hp = %m_hp
@onready var m_lv = %m_lv

@onready var t_attack:TweenProgress = $t_attack

var actor:GameActor

func _ready():
	setup()
	pass 

func _process(delta):
	pass

func setup():
	actor = GameActor.new();
	actor.primary_stats.add_event(update,"monster_stats_change")
#	t_attack.set_interval(2).start()

func update(changes):
	m_hp.text = actor.get_hp(true)
	m_lv.text = "Lv:{0}".format([str(actor.primary_stats.LEVEL)])

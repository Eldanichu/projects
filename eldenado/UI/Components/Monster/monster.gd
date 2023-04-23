extends Control

onready var hp_bar = $"%hp"
onready var act_bar = $"%act"
onready var mon_img := $"%image"

var bleeding:Particles2D
var action_timer := ATimer.new(self)

var mon:MonObj
var mon_stat:Dictionary

func _ready() -> void:
	setup()
	hp_bar.t_max = 100
	act_bar.t_max = 100

func setup():
	if !is_instance_valid(mon):
		print("[monster](setup) monster was not instanced")
		return
	add_child(mon)
	mon_stat = mon.mon_stat
	action_timer.Interval = mon_stat.atk_speed
	action_timer.connect("timeout",self,"_attack")
	action_timer.connect("remains" ,self,"_attack_cd")
	action_timer.start_timer()

func _attack():
	var p = GameUtils.get_percent(mon_stat.atk_speed,mon_stat.atk_speed)
	act_bar.t_val = p
	action_timer.start_timer()
	print("attacks",mon.attack())
	pass

func _attack_cd(sec):
	var p = GameUtils.get_percent(sec,mon_stat.atk_speed)
	act_bar.t_val = str(p)
	pass

extends Control

signal spawned()
signal on_attack(info)
signal dead()
signal drop(drops)

onready var hp_bar = $"%hp"
onready var act_bar = $"%act"
onready var mon_img := $"%image"

var bleeding:Particles2D
var action_timer := ATimer.new(self)

var mon:MonObj
var mon_stat:Dictionary

func _ready() -> void:
	setup()

func _process(delta: float) -> void:
	if not is_instance_valid(mon):
		return
	if not mon.alive():
		emit_signal("dead")
		var drops = mon.drop()
		emit_signal("drop",drops)
		mon.queue_free()
		queue_free()

func setup():
	if !is_instance_valid(mon):
		print("[monster](setup) monster was not instanced")
		return
	add_child(mon)
	set_mon_stats()
	emit_signal("spawned")
	action_timer.connect("timeout",self,"_attack")
	action_timer.connect("remains" ,self,"_attack_cd")
	action_timer.stop()
	action_timer.start_timer()

func set_mon_stats():
	mon_stat = mon.mon_stat
	mon_img.texture = load(mon_stat.appr)
	mon_stat.atk_interval = mon_stat.atk_speed * 1.0 / 1000
	action_timer.Interval = mon_stat.atk_interval
	mon_stat.hp_max = mon_stat.hp
	hp_bar.t_max = mon_stat.hp_max
	hp_bar.t_val = mon_stat.hp
	act_bar.t_max = 100
	var p = GameUtils.get_percent(mon_stat.atk_interval, mon_stat.atk_interval)
	act_bar.t_val = p

func _attack():
	var p = GameUtils.get_percent(mon_stat.atk_interval, mon_stat.atk_interval)
	act_bar.t_val = p
	action_timer.start_timer()
	var atk = mon.attack()
	emit_signal("on_attack",{
		"name": mon_stat.name,
		"damage": atk
	})
	if atk < 0:
		action_timer.stop()

func _attack_cd(sec):
	var p = GameUtils.get_percent(sec,mon_stat.atk_interval)
	act_bar.t_val = str(p)
	pass

func take_damage(damage):
	mon_stat.hp = mon_stat.hp - damage

func wait():
	action_timer.stop()

func start():
	action_timer.resume()

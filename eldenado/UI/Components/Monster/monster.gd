extends Control

signal spawned()
signal on_attack(info)
signal dead(expr)
signal drop(drops)

onready var hp_bar = $"%hp"
onready var act_bar = $"%act"
onready var mon_img := $"%image"
onready var mon_name := $"%mon_name"

onready var anim := $anim

var ft := preload("res://UI/Components/FloatingText/floating_text.tscn")
var stylebox = preload("res://Assets/Themes/panel_border.tres")
var action_timer := ATimer.new(self)

var mon_obj:MonObj
var mon_stat:Dictionary

var r := RandomNumberGenerator.new()
var tansform := get_transform()
var shake_period := 5.0
var shake_time := 0.0
var shke_strength = 2
var origin
var taking_damage = false

func _ready() -> void:
	r.randomize()
	setup()

func _process(delta: float) -> void:
	if not is_instance_valid(mon_obj):
		return

	if taking_damage:
		shake(delta)

func setup():
	if !is_instance_valid(mon_obj):
		print("[monster](setup) monster was not instanced")
		return
	bind_event()
	add_child(mon_obj)
	set_mon_stats()
	emit_signal("spawned")
	action_timer.connect("timeout",self,"_attack")
	action_timer.connect("remains" ,self,"_attack_cd")
	action_timer.stop()
	action_timer.start_timer()

func bind_event():
	anim.connect("animation_finished",self,"_on_disapper")
	mon_obj.connect("die",self,"_on_monster_die")

func set_mon_stats():
	mon_stat = mon_obj.mon_stat
	mon_img.texture = load(mon_stat.appr)
	mon_name.text = mon_stat.name

	mon_stat.atk_interval = mon_stat.atk_speed * 1.0 / 1000
	action_timer.Interval = mon_stat.atk_interval
	mon_stat.hp_max = mon_stat.hp
	hp_bar.t_max = mon_stat.hp_max
	hp_bar.t_val = mon_stat.hp
	act_bar.t_max = 100
	var p = GameUtils.get_percent(mon_stat.atk_interval, mon_stat.atk_interval)
	act_bar.t_val = p

func set_border_color(color:Color = Color.green):
	stylebox.border_color = color
	add_stylebox_override("panel",stylebox.duplicate())

func shake(delta):
	var last_p = origin
	if shake_time <= shake_period:
		var p = rect_position
		var tp = Vector2(rect_position) - Vector2(r.randi_range(shke_strength, -shke_strength), 0)
		tansform.x = lerp(p, tp, 1.0)
		rect_position.x = tansform.x.x
		last_p = rect_position.x
	else:
		rect_position = lerp(last_p, origin, 1)
		shake_time = 0.0
		taking_damage = false
	shake_time += delta * 60

func take_damage(damage):
	taking_damage = true
	mon_obj.take_damge(damage)
	hp_bar.t_val = mon_stat.hp
	yield(get_tree(),"idle_frame")
	update_origin_position()
	float_damage_number(damage)
#	set_border_color()
#	yield(get_tree().create_timer(1,0),"timeout")
#	set_border_color(Color("#545454"))

func update_origin_position():
	origin = get_position()

func float_damage_number(damage):
	var f = ft.instance()
	f.position = get_global_position() - origin + (rect_size * 0.3)
	f.label = damage
	add_child(f)

func wait():
	action_timer.stop()

func start():
	action_timer.resume()

"""
Events
"""
func _attack():
	var p = GameUtils.get_percent(mon_stat.atk_interval, mon_stat.atk_interval)
	act_bar.t_val = p
	action_timer.start_timer()
	var atk = mon_obj.attack()
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

func _on_disapper(anim_name):
	mon_obj.queue_free()
	queue_free()

func _on_monster_die():
	emit_signal("dead",mon_stat.exp)
	anim.play("disapper")
	var drops = mon_obj.drop()
	emit_signal("drop",drops)

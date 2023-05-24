extends Control
class_name Monster

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
var action_value:float = 0

var mon_obj:MonObj
var mon_stat:Dictionary
var hover:bool = false

var r := RandomNumberGenerator.new()
var tansform := get_transform()
var origin:Vector2 = Vector2.ZERO


func _ready() -> void:
	r.randomize()
	setup()

func _process(delta: float) -> void:
	act_bar.t_val = str(action_value)
	hp_bar.t_val = mon_stat.hp

	if not valid():
		return

func _input(event) -> void:
	pass


func setup():
	if !is_instance_valid(mon_obj):
		print("[monster](setup) monster was not instanced")
		return
	bind_event()
	add_child(mon_obj)
	emit_signal("spawned")
	set_mon_stats()
	auto_attack_timer()

func bind_event():
	connect("mouse_entered",self, "_on_mouse", [true])
	connect("mouse_exited",self, "_on_mouse", [false])
	anim.connect("animation_finished",self,"_on_disapper")
	mon_obj.connect("damage",self,"_on_monster_damage")
	mon_obj.connect("die",self,"_on_monster_die")

func set_mon_stats():
	mon_stat = mon_obj.mon_stat
	mon_img.texture = load(mon_stat.appr)
	mon_name.text = mon_stat.name
	mon_stat.atk_interval = (mon_stat.atk_speed + r.randf_range(100,180)) * 1.0 / 1000
	action_timer.Interval = mon_stat.atk_interval
	mon_stat.hp_max = mon_stat.hp
	hp_bar.t_max = mon_stat.hp_max
	hp_bar.t_val = mon_stat.hp
	act_bar.t_max = 100
	var p = GameUtils.get_percent(mon_stat.atk_interval, mon_stat.atk_interval)
	act_bar.t_val = p

func auto_attack_timer():
	action_timer.connect("timeout",self, "_attack")
	action_timer.connect("remains" ,self, "_attack_cd")
	action_value = GameUtils.get_percent(mon_stat.atk_interval, mon_stat.atk_interval)
	action_timer.start_timer()

func set_border_color(color:Color = Color.green):
	stylebox.border_color = color
	add_stylebox_override("panel",stylebox.duplicate())

func _select_border():
	set_border_color()
	yield(get_tree().create_timer(1,0),"timeout")
	set_border_color(Color("#545454"))

func update_origin_position():
	origin = get_position()
	print("[monster] origin position:",origin)

func float_damage_number(damage):
	var f = ft.instance()
	f.position = get_global_position() - origin + (rect_size * 0.3)
	f.label = damage
	add_child(f)

func wait():
	action_timer.pause()

func starts_battle():
	action_timer.resume()

func valid():
	return is_instance_valid(mon_obj) && not mon_obj.is_dead()

func hovering():
	return hover

"""
Events
"""
func _attack():
	emit_signal("on_attack", mon_obj)
	action_timer.start_timer()

func _attack_cd(sec):
	action_value = GameUtils.get_percent(sec,mon_stat.atk_interval)

func _on_monster_damage(damage):
	yield(get_tree(),"idle_frame")
	update_origin_position()
	float_damage_number(damage)
	anim.play("shake")

func _on_monster_die():
	wait()
	emit_signal("dead",mon_stat.exp)
	anim.play("disapper")
	var drops = mon_obj.drop()
	emit_signal("drop",drops)

func _on_disapper(anim_name):
	if anim_name == "disapper":
		mon_obj.queue_free()
		queue_free()

func _on_mouse(v):
	print("[monster]-> on mouse hovering:",v)
	hover = v

extends Control

onready var hp_bar = $"%hp"
onready var act_bar = $"%act"
onready var mon_img := $"%image"
onready var p_bleeding := preload("res://Particles/bleeding.tscn")

var bleeding:Particles2D
var hp:int = 0
var atk_interval:float = 2
var action_timer := ATimer.new(self)

var mon := MonObj.new()

func _ready() -> void:
	add_child(mon)
	hp_bar.t_max = 100
	act_bar.t_max = 100
	action_timer.connect("timeout",self,"_attack")
	action_timer.connect("remains" ,self,"_attack_cd")
	action_timer.Interval = atk_interval
	action_timer.start_timer()
	bleeding = p_bleeding.instance()
#	add_child(bleeding)
#	bleeding.position = (rect_size - mon_img.texture.get_size()) * .5
	

func _attack():
	var p = GameUtils.get_percent(atk_interval,atk_interval)
	act_bar.t_val = p
	action_timer.start_timer()
	print("attacks",RandomUtil.get_random(3))
	bleeding.emitting = true

	pass

func _attack_cd(sec):
	var p = GameUtils.get_percent(sec,atk_interval)
	act_bar.t_val = str(p)
	pass

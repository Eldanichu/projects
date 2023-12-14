extends Control
class_name BattleScene

const MonScene = preload("res://Components/Monster/monster.tscn")

var p:GamePlayer
var mons:Array[MonObject] = []

var battle_timer:TimerEx

@onready var time = %time
@onready var mon = %mon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_map(map_id):
	if not mon:
		print_stack()
		return
	var mons = dbc.query_map_mon_group(map_id)
	print(mons)
	for m in mons:
		var mon_id = m['ID']
		var mon_obj = MonObject.new(mon_id)
		var mon_scene:MonsterScene = MonScene.instantiate()
		mon_scene.mon_obj = mon_obj
		mon.add_child(mon_scene)


func has_player() -> bool:
	if p:
		return true
	return false

func has_mon():
	return len(mons)

func start_battle():
	if not has_player():
		print_stack()
		return
	if not has_mon():
		print_stack()
		return
	if not battle_timer:
		battle_timer = TimerEx.new(self)
	battle_timer.on_tick.connect(battle_timer_on_tick)
	battle_timer.start()

func close_battle_timer():
	if not battle_timer:
		return
	battle_timer.reset()

func spawn_mon(mon:MonObject):
	mons.append(mon)
	mon.attach_to_node(mon)

func despawn_mon():
	pass

func battle_timer_on_tick(tick):
	time.text = str(tick)

func open():
	var parent = get_parent()
	parent.visible = true

func close():
	close_battle_timer()
	pass
	

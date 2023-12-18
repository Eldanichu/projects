extends Control
class_name BattleScene

signal started()
signal process()
signal ended()

const monster_scene = preload("res://Components/MonsterScene/monster_scene.tscn")

class BattleCounter:
	var mons:Array[MonsterScene] = []
	
	var current = -1
	var total = 0
	
	func _init():
		reset()
		pass
	
	func add(_var):
		mons.append(_var)
		update_total()
	
	func remove(mon_scene_name:String):
		var index = 0
		for ms in mons:
			if mon_scene_name == ms.name:
				ms.kill()
				is_battle_end()
			index += 1

	func remove_all():
		var len = len(mons) - 1
		var ms
		for i in range(len,-1,-1):
			ms = mons[i] as MonsterScene
			mons.remove_at(i)
			ms.queue_free()
		reset()
	
	func reset():
		current = -1
		total = 0
	
	func next():
		var _max = total - 1
		if current >= _max:
			current = _max
			return
		current += 1
	
	func update_total():
		total = len(mons)

	func battle_next():
		if is_battle_end():
			return
		next()
		mons[current].auto_attack()
	
	func is_battle_end():
		var ended = true
		for ms in mons:
			if not ms.is_dead():
				ended = false
		if ended:
			remove_all()
		return ended

var player_scene:GamePlayer
var player_obj:ActorPlayer
var battle_timer:TimerEx
var bc:BattleCounter = BattleCounter.new()

@onready var time = %time
@onready var mon = %mon
@onready var char_stat:CharStat = %char_stat

func _ready():
	pass

func set_map(map_id):
	if not mon:
		print_stack()
		return
	var mon_group = dbc.query_map_mon_group(map_id)
	for _mon_row in mon_group:
		var mon_id = _mon_row['ID']
		spawn(mon_id)
	start_battle()

func spawn(mon_id):
	var mon_obj = MonObject.new(mon_id)
	var mon_scene:MonsterScene = monster_scene.instantiate()
	mon_scene.spawned.connect(_on_monster_spawned)
	mon_scene.attack.connect(_on_monster_attack)
	mon_scene.dead.connect(_on_monster_dead)
	mon_scene.mon_obj = mon_obj
	mon.add_child(mon_scene)
	bc.add(mon_scene)

func start_battle():
	if not has_player():
		print_stack()
		return
	if not has_mon():
		print_stack()
		return
	P.dead.disconnect(_on_player_dead)
	P.dead.connect(_on_player_dead)
	open()
	started.emit()
	update_ui()

func setup_battle_timer():
	if not battle_timer:
		battle_timer = TimerEx.new(self)
		battle_timer.interval = 60
	battle_timer.on_tick.connect(_battle_timer_on_tick)
	battle_timer.start()

func close_battle_timer():
	if not battle_timer:
		return
	battle_timer.reset()

func _switch_panel(show:bool = false):
	var parent = get_parent()
	parent.visible = show

func open():
	_switch_panel(true)
	char_stat.on_battle = true
	setup_battle_timer()
	bc.battle_next()

func close():
	_switch_panel(false)
	close_battle_timer()
	char_stat.on_battle = false
	bc.remove_all()
	ended.emit()

func update_ui():
	player_obj = player_scene.player
	char_stat.player_scene = player_scene
	char_stat.bind_event()

func has_player() -> bool:
	if player_scene:
		return true
	return false

func has_mon():
	return bc.total

func _battle_timer_on_tick(tick):
	time.text = str(int(tick))

func _on_player_dead():
	close()

func _on_monster_spawned(mon_inst:MonsterScene):
	print("[battle]{_on_monster_spawned} ->",mon_inst.name)

func _on_monster_attack(mon_inst:MonsterScene,dmg):
	print("[battle]{_on_monster_attack} ->",mon_inst, dmg)
	mon_inst.mon_obj.use_attack(player_scene.player)

func _on_monster_dead(mon_inst:MonsterScene):
	print("[battle]{_on_monster_dead} ->",mon_inst)
	bc.remove(mon_inst.name)
	if bc.is_battle_end():
		close()
	bc.battle_next()
	
	
	

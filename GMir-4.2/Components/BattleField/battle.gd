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
				battle_next()
			index += 1

	func remove_all():
		var len = len(mons) - 1
		var ms
		for i in range(len,-1,-1):
			ms = mons[i] as MonsterScene
			mons.remove_at(i)
			ms.queue_free()
		reset()
	
	func get_target() -> MonObject:
		if not has_target():
			return null
		return get_current().mon_obj

	func has_target() -> bool:
		var _cur := get_current()
		if not _cur:
			return false
		if _cur.is_dead():
			return false
		return true

	func get_current() -> MonsterScene:
		if mons.is_empty():
			return null
		var _cur = mons[current] as MonsterScene
		
		return _cur
	
	func reset():
		current = -1
		total = 0
	
	func next():
		if not has_next():
			return
		current += 1
	
	func has_next() -> bool:
		var _max = total - 1
		if current >= _max:
			current = _max
			return false
		return true
	
	func update_total():
		total = len(mons)

	func battle_next():
		if is_battle_end():
			return
		next()
		get_current().auto_attack()
	
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
	mon_scene.mon_obj = mon_obj
	var mon_scene_obj = mon_scene.mon_obj
	mon_scene_obj.spawned.connect(_on_monster_spawned)
	mon_scene_obj.on_attack.connect(_on_monster_attack)
	mon_scene_obj.on_dead.connect(_on_monster_dead)
	mon.add_child(mon_scene)
	mon_scene_obj.stats_change.emit()
	bc.add(mon_scene)

func start_battle():
	if not has_player():
		print_stack()
		return
	if not has_mon():
		print_stack()
		return
	open()
	started.emit()
	update_ui()
	player_obj.on_attack.connect(_on_player_attack)

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
	player_scene.start_battle()

func close():
	_switch_panel(false)
	close_battle_timer()
	char_stat.on_battle = false
	bc.remove_all()
	ended.emit()

func update_ui():
	player_obj = player_scene.player
	char_stat.player_obj = player_obj
	char_stat.bind_event()
	player_obj.stats_change.emit()

func has_player() -> bool:
	if player_scene:
		return true
	return false

func has_mon():
	return bc.total

func _battle_timer_on_tick(tick):
	time.text = str(int(tick))

func _on_player_attack():
	log.d("player attack")
	var target := bc.get_target()
	
	player_obj.attack(target)

func _on_player_dead():
	close()

func _on_monster_spawned(mon_inst:MonsterScene):
	print("[battle]{_on_monster_spawned} ->",mon_inst.name)

func _on_monster_attack(mon_inst:MonsterScene):
	print("[battle]{_on_monster_attack} ->",mon_inst)
	mon_inst.mon_obj.attack(player_scene.player)

func _on_monster_dead(mon_inst:MonsterScene):
	print("[battle]{_on_monster_dead} ->",mon_inst)
	bc.battle_next()
	
	

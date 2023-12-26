extends Control
class_name BattleScene

signal started()
signal process()
signal ended()

const monster_scene = preload("res://Components/MonsterScene/monster_scene.tscn")

var _map_id = "-1"
var _player_scene:GamePlayer
var _player:ActorPlayer
var battle_timer:TimerEx
var bc:BattleCounter = BattleCounter.new()

@onready var time = %time
@onready var mon = %mon
@onready var char_stat:CharStat = %char_stat

func _ready():
	pass

func initialize(map_id, player:ActorPlayer,player_scene:GamePlayer):
	_map_id = map_id
	_player = player
	_player_scene = player_scene
	if _map_id == "-1" or not _player:
		printerr("map_id or player error")
		return
	char_stat.player = player
	char_stat.initialize()
	player_event()
	var mon_group = dbc.query_map_mon_group(_map_id)
	for _mon_row in mon_group:
		var mon_id = _mon_row['ID']
		spawn(mon_id)
	bc.next()
	player_scene.start_battle()

func spawn(mon_id):
	var mon_obj = MonObject.new(mon_id)
	var mon_scene:MonsterScene = monster_scene.instantiate()
	mon_scene.mon_obj = mon_obj
	monter_event(mon_scene)
	mon.add_child(mon_scene)
	bc.add(mon_scene)

func player_event():
	_player.spawnd.connect(_on_player_spawned)
	_player.on_attack.connect(_on_player_attack)
	_player.on_dead.connect(_on_player_dead)

func monter_event(scene:MonsterScene):
	var _obj = scene.mon_obj
	_obj.spawned.connect(_on_mon_spawned)
	_obj.on_attack.connect(_on_mon_attack)
	_obj.on_dead.connect(_on_mon_dead.bind(scene))

func start_battle():
	if not has_player():
		print_stack()
		return
	if not has_mon():
		print_stack()
		return
	open()
	battle_timer.start()
	started.emit()

func setup_battle_timer():
	if not battle_timer:
		battle_timer = TimerEx.new(self)
		battle_timer.interval = 60
	battle_timer.on_tick.connect(_on_battle_process)
	battle_timer.on_timeout.connect(_battle_time_out)
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
	char_stat.battle_options = true
	setup_battle_timer()

func close():
	_switch_panel(false)
	close_battle_timer()
	char_stat.battle_options = false
	bc.remove_all()
	ended.emit()

func has_player() -> bool:
	if _player:
		return true
	return false

func has_mon():
	return bc.total

func _on_battle_process(tick):
	time.text = str(int(tick))
	process.emit()

func _battle_time_out():
	close_battle_timer()
	ended.emit()

func _on_player_spawned():
	print("[battle] player spawned")
	pass

func _on_player_attack():
	print("[battle] player attacks")
	var _cur = bc.get_current()
	if not _cur:
		return
	_player.attack(_cur.mon_obj)

func _on_player_dead():
	print("[battle] player dead")
	pass

func _on_mon_spawned():
	print("[battle] monster spawned")
	pass

func _on_mon_attack():
	print("[battle] monster attacks")
	pass

func _on_mon_dead(scene):
	print("[battle] monster dead")
	bc.remove(scene.name)
	bc.next()
	pass









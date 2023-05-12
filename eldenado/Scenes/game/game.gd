extends Node2D

onready var stat := $"%stats"
onready var map := $"%Maps"
onready var inv := $"%imventory"

onready var idel := $"%idel"
onready var game_panel := $"%game_panel"

onready var battle_panel := $"%battle_panel"

var db:DB
var player:PlayerObj
var player_info:Dictionary

func _ready() -> void:
	load_game_data()

func _process(delta: float) -> void:
	pass

func setup(_player_info:Dictionary):
	player_info = _player_info

func load_game_data():
	db = DB.new()
	db.connect("db_ready",self,"_on_db_ready")
	add_child(db)


func load_maps():
	if !map:
		return
	var maps = db.get_data("map")
	map.MapData = maps.data
	map.load_data()
	map.connect("map_entering",self,"_map_entering")

func create_player():
	player = PlayerObj.new()
	add_child(player)
	player.connect("update_stats",self,"_update_stats")
	if !player_info:
		return
	player.setup(player_info)


"""
 Events

"""
func _on_db_ready():
	print("db ready")
	load_maps()
	create_player()
	bind_events()

func bind_events():
	pass

func _map_entering(e):
	set_battle(true)
	var map_name = e.name
	var mon_ids = RandomUtil.get_map_monsters(db, map_name)
	var monsters = []
	for _mon_id in mon_ids:
		var mon = MonObj.new()
		mon.get_instance(db, _mon_id)
		monsters.append(mon)
	battle_panel.set_player(player)
	battle_panel.monsters = monsters

func _update_stats(_stat:Dictionary):
	_stat.merge(player_info, true)
	stat.update_ui(_stat)

func _on_game_panel_switch_panel(panel_name) -> void:
	if panel_name == "battle":
		map.visible = !map.visible

func set_battle(battle:bool):
	idel.visible = !battle
	battle_panel.visible = battle

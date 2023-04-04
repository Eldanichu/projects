extends Node2D

onready var stat := $"%stats"
onready var logger := $"%logger"
onready var map := $gmae_ui/control/v_box_container/center_container_2/Maps

var db:DB
var player:PlayerObj
var player_info:Dictionary

func setup(_player_info:Dictionary):
	load_game_data()
	player_info = _player_info

func load_game_data():
	db = DB.new(self)
	db.connect("db_ready",self,"_on_db_ready")

func _on_db_ready():
	load_maps()
	create_player()

func load_maps():
	var maps = db.get_data("map")
	map.MapData = maps.data
	map.load_data()
	map.connect("map_entering",self,"_map_entering")

func create_player():
	player = PlayerObj.new()
	add_child(player)
	player.connect("update_stats",self,"update_stat_panel")
	player.setup(player_info)

func _map_entering(e):
	print(e)

func update_stat_panel(stats:Dictionary):
	stat.player_name = player_info.player_name
	for stat_key in stats:
		stat[stat_key] = stats[stat_key]
	stat.update()

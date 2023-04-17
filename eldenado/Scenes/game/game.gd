extends Node2D

onready var stat := $"%stats"
onready var logger := $"%logger"
onready var map := $"%Maps"
onready var inv := $"%imventory"

var db:DB
var player:PlayerObj
var player_info:Dictionary

func setup(_player_info:Dictionary):
	load_game_data()
	player_info = _player_info

func load_game_data():
	db = DB.new(self)
	db.connect("db_ready",self,"_on_db_ready")

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
	player.setup(player_info)


"""
 Events

"""
func _on_db_ready():
	load_maps()
	create_player()

func _map_entering(e):
	print(e)
	player.make_damage(1)

func _update_stats(stats:Dictionary):
	stat.player_name = player_info.player_name
	for stat_key in stats:
		stat[stat_key] = stats[stat_key]
	stat.update()

extends Node2D

onready var stat := $"%stats"
onready var logger := $"%logger"
onready var map := $gmae_ui/control/v_box_container/center_container_2/Maps

var db:DB
var player:PlayerObj
var _player_info

func setup(player_info:Dictionary):
	load_game_data()
	_player_info = player_info

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

func create_player():
	player = PlayerObj.new()
	add_child(player)
	player.connect("update_stats",self,"update_panel")
	player.setup(_player_info)

func update_panel(stats:Array):
	var _class = Globals.CLASS_NAME[player.class_type]
	stat.PlayerClass = _class
	stat.PlayerName = player.player_name
	stat.Hp = stats[0]
	stat.MaxHp = stats[1]
	stat.Mp = stats[2]
	stat.MaxMp = stats[3]
	stat.Exp = stats[4]
	stat.MaxExp = stats[5]
	stat.Level = stats[6]
	stat.update()

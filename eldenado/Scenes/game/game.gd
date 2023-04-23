extends Node2D

onready var stat := $"%stats"
onready var logger := $"%logger"
onready var map := $"%Maps"
onready var inv := $"%imventory"

var db:DB
var player:PlayerObj
var player_info:Dictionary

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

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
	var map_name = e.name
	var mon_ids = RandomUtil.get_map_monsters(db, map_name)
	print(mon_ids)
	for _mon_id in mon_ids:
		var mon = MonObj.new()
		mon.get_instance(db, _mon_id)


func _update_stats(_stat:Dictionary):
	_stat.merge(player_info, true)
	stat.update_ui(_stat)

func _on_game_panel_switch_panel(panel_name) -> void:
	if panel_name == "battle":
		map.visible = !map.visible

extends Node2D

onready var stat := $"%stats"
onready var map := $"%Maps"
onready var inv := $"%inventory"
onready var character := $"%character"

onready var idel := $"%idel"
onready var game_panel := $"%game_panel"

onready var battle_panel := $"%battle_panel"

var db:DB
var player:PlayerObj
var player_info:Dictionary

func _ready() -> void:
	load_game_data()
	bind_events()

func _process(delta: float) -> void:
	pass

func setup(_player_info:Dictionary):
	player_info = _player_info

func load_game_data():
	db = DB.new()
	Event.connect("db_ready", self, "_on_db_ready")
	add_child(db)

func bind_events():
	battle_panel.connect("battle_start",self,"_on_battle_start")
	battle_panel.connect("battle_end",self,"_on_battle_end")

func load_maps():
	if !map:
		return
	var maps = db.get_data("map")
	map.MapData = maps.data
	map.load_data()
	map.connect("map_click",self,"_on_map_click")

func create_player():
	player = PlayerObj.new()
	player.connect("ablity_change",self,"_on_player_ablity_change")
	player.connect("stats_change",self,"_on_player_stats_change")
	player.connect("die",self,"_on_player_die")
	player.connect("levelup",self,"_on_player_levelup")
	add_child(player)
	if !player_info:
		return
	player.setup(player_info)
	Event.emit_signal("player_ready", player)

func make_item(id:String) -> ItemObject:
	var item:ItemObject = ItemObject.new()
	item.set_target(player)
	item.id = id
	item.set_db(db)
	item.cd = 0.1
	item.size = 5
	item.get_instance()
	return item

func init_player():
	player.give_item(make_item("posion_mp_0"))
	player.give_item(make_item("posion_hp_0"))

func update_ui():
	stat.update_ui(player.stats)
	character.update_stats(player.stats)

func set_battle(battle:bool):
	idel.visible = !battle
	battle_panel.visible = battle
	stat.show_command = battle

"""
 Events
"""
func _on_db_ready(db:DB):
	print("[game] -> DB ready",db)
	load_maps()
	create_player()
	init_player()
	update_ui()

func _on_map_click(e):
	Event.emit_signal(Event.BUTTON_AUDIO.MENU_BUTTON)
	var map_name = e.name
	var mon_ids = RandomUtil.get_map_monsters(db, map_name)
	var mon_objs:Array = []
	for _mon_id in mon_ids:
		var mon = MonObj.new()
		mon.get_instance(db, _mon_id)
		mon_objs.append(mon)
	battle_panel.mon_objs = mon_objs

func _on_player_ablity_change():
	pass

func _on_player_stats_change(_stat:Dictionary):
	_stat.merge(player_info, true)
	update_ui()

func _on_player_die():
	print("[battle]palyer die")
	battle_panel.battle_state = battle_panel.BATTLE_STATUS.FAIL
	battle_panel.kill_all_monsters()
	battle_panel.emit_battle_end()
	set_battle(false)
	player.revive()

func _on_player_levelup():
	Event.emit_signal("level_up")

func _on_battle_start():
	set_battle(true)
	player.state = Globals.PLAYER_STATE.BATTLE

func _on_battle_end():
	print("[game]-> battle state:end")
	set_battle(false)
	player.state = Globals.PLAYER_STATE.IDEL

func _on_game_panel_switch_panel(panel_name) -> void:
	Event.emit_signal(Event.BUTTON_AUDIO.MENU_BUTTON)
	if not panel_name in self:
		return
	self[panel_name].visible = !self[panel_name].visible


extends MarginContainer

onready var stat_panel := $"%stat_panel"
var stat_line := preload("res://UI/Panels/Character/stat_line.tscn")
var g:Globals = Globals.new()

var player_stats:Dictionary

func _ready():
	Event.connect("player_ready", self, "_set_player")
	load_stats_tab()
	load_skill_tab()
	load_equip_tab()

func _set_player(player:PlayerObj):
	update_stats(player.stats)

func update_stats(stats):
	player_stats = stats
	update_stats_tabs()

func load_equip_tab():
	pass

func load_stats_tab():
	var g_keys = g.char_panel_stat
	for i in range(g_keys.size()):
		var g_key:String = g_keys[i][0]
		var stat := stat_line.instance()
		stat.name = g_key
		var _split_values = g_key.split("-")
		if _split_values.size() > 1:
			stat.line.name = g_keys[i][2]
			stat_panel.add_child(stat)
			continue
		stat.line.name = g_keys[i][2]
#		stat.line.value = "{0}{1}".format([player_stats[g_key],g_keys[i][1]])
		stat_panel.add_child(stat)

func update_stats_tabs():
	if !is_inside_tree():
		return
	var g_keys = g.char_panel_stat
	for i in range(g_keys.size()):
		var g_key:String = g_keys[i][0]
		var stat := stat_panel.get_node(g_key)
		var _split_values = g_key.split("-")
		if _split_values.size() > 1:
			stat.line.value = "{0}-{1}".format([
				round(player_stats[_split_values[0]]),
				round(player_stats[_split_values[1]])
			])
			continue
		stat.line.value = "{0}{1}".format([player_stats[g_key],g_keys[i][1]])

func load_skill_tab():
	pass

extends Control
class_name GUI

@onready var mon_stat_page = %mon_stat_page
@onready var mon_ui:MonUI = %mon_ui

@onready var player_stat_page = %player_stat_page
@onready var attack = %Attack

var player:GameObject
var enemy:GameObject

func _ready():
	pass

func pui(obj:GameObject):
	player = obj
	player_stat_page.obj = obj
	player_stat_page.update_prop_ui()
	
func mui(obj:GameObject):
	enemy = obj
	mon_stat_page.obj = obj
	mon_stat_page.update_prop_ui()
	update_monster_ui()

func update_monster_ui():
	var properties = enemy.properties as MonsterProperties
	mon_ui.mname = properties.mname
	mon_ui.hp = properties.hp
	mon_ui.hp_max = properties.hp_max
	mon_ui.mp = properties.mp
	mon_ui.mp_max = properties.mp_max
	mon_ui.action = properties.atk_spd
	
func _on_visibility_changed():
	var _show = visible
	T.set_pause(self,_show)
	
	

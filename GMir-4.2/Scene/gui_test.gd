extends Control
class_name GUI

@onready var mon_stat_page = %mon_stat_page
@onready var mon_ui:MonUI = %mon_ui

@onready var player_stat_page = %player_stat_page
@onready var attack = %Attack


func _ready():
	
	pass


func pui(obj:GameObject):
	player_stat_page.obj = obj
	player_stat_page.update_prop_ui()
	
func mui(obj:GameObject):
	mon_stat_page.obj = obj
	mon_ui.hp = obj.properties.hp
	mon_ui.hp_max = obj.properties.hp_max
	mon_stat_page.update_prop_ui()
	
	

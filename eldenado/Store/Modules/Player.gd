extends Node2D
class_name Player

var player_data = {}

func save(player_obj:PlayerObj):
	var copy_of_player = player_obj.duplicate()
	var _name = copy_of_player.player_name
	player_data[_name] = copy_of_player

func delete_player(name:String):

	pass

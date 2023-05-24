## Global Events
extends Node


"""
Game
"""
signal create_game(result)
signal battle_command(type)

"""
Player
"""
signal on_target(target)
signal player_attack(slot_obj)

"""
Audio
"""
signal button_pressed()
signal menu_button_pressed()
signal checkbox_pressed()
signal link_pressed()

signal level_up()

const BUTTON_AUDIO:Dictionary = {
	BUTTON = "button_pressed",
	MENU_BUTTON = "menu_button_pressed",
	LINK = "link_pressed",
}


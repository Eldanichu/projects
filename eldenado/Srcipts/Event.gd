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
signal player_attack()

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


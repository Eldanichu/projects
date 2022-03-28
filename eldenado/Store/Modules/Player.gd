extends Node
class_name Player

var player_name = "player_name"
var gold = 0
var level = 0
var class_type = 1

var hp = 0
var hp_max = 1

var mp = 0
var mp_max = 1

var iExp = 0
var iExp_max = 1

func taken_damage(damge:int):
  hp = hp - damge

func level_up():
  level = level + 1
  mp = mp_max
  hp = hp_max
  iExp = 0

func get_stats() -> Dictionary:
  return {
    "player_name":player_name,
    "gold":gold,
    "level":level,
    "class_type":class_type,
    "iExp":iExp
   }

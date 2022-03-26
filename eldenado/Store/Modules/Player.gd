extends Node
class_name Player

var level = 1
var class_type = 1

var hp = 1
var hp_max = 1

var mp = 1
var mp_max = 1

var iExp = 1
var iExp_max = 1

func get_stats() -> Dictionary:
  return {
    "level":level,
    "class_type":class_type,
    "iExp":iExp
   }

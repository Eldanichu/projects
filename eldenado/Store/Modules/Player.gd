extends Node
class_name Player

var level = 1

var hp = 1
var hp_max = 1

var mp = 1
var mp_max = 1

var exper = 1
var exper_max = 1

func level_up():
  level = level + 1
  reset_exp()

func reset_exp():
  exper = 0

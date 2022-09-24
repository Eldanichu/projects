extends Node
class_name Player

var player_name = "unnamed"
var gold = 0
var level = 1
var c_class = 1
var t_class = ""

var hp = 0
var hp_max = 1

var mp = 0
var mp_max = 1

var c_exp = 0
var c_exp_max = 1

func setup():
  pass

func set_player_name(name:String):
  player_name = name

func set_player_class(class_type):
  c_class = class_type
  t_class = Globals.ClassName[c_class]

func get_class_name():
  return t_class

func updateStats():
  var _g = Globals.new()
  var _stat = _g.get_class_stats(level,c_class)
  hp_max = _stat.max_hp
  mp_max = _stat.max_mp
  var _exp = _g.get_exp_by_level(level)
  c_exp_max = _exp

func levelup():
  level = level + 1
  updateStats()
  hp = hp_max
  mp = mp_max
  c_exp = 0




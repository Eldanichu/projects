extends Control

onready var stats = find_node('stats')

var globals:Globals = Globals.new()

func _ready() -> void:
  Logger.debug('game ready')
  setup()
  pass

func setup():
  stats.connect("exp_change",self,"_exp_change")
  var class_stats:Dictionary = globals.get_class_stats(1)
  stats.hp_max = class_stats.max_hp
  stats.hp = stats.hp_max
  stats.mp_max = class_stats.max_mp
  stats.mp = stats.mp_max
  stats.iExp_max = 1000


func _exp_change(e,percent,income):
  Logger.debug(str(percent))

func _exit_tree() -> void:
  queue_free()

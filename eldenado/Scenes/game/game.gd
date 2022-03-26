extends Control

onready var stats = find_node('stats')

var globals:Globals = Globals.new()

func _ready() -> void:
  Logger.debug('game ready')
  stats.level = 1
  update_stats()
  init_stats()
  stats.connect("exp_change",self,"_exp_change")

func update_stats():
  var level = stats.level
  var class_stats:Dictionary = globals.get_class_stats(level)
  stats.hp_max = class_stats.max_hp
  stats.mp_max = class_stats.max_mp
  stats.iExp_max = globals.get_exp_by_level(level)

func init_stats():
  stats.hp = stats.hp_max
  stats.mp = stats.mp_max
  stats.iExp = 0

func level_up():
  stats.level = stats.level + 1

func _exp_change(e,percent,income):
  if percent >= 100:
    level_up()
    update_stats()
    init_stats()
  pass

func _exit_tree() -> void:
  queue_free()

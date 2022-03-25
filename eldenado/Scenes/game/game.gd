extends Control

onready var stats = find_node('stats')

var globals:Globals = Globals.new()

func _ready() -> void:
  Logger.debug('game ready')
  setup()


func setup():
  stats.connect("exp_change",self,"_exp_change")
  update_player()

func update_player():
  var level = Store.player.level
  var class_stats:Dictionary = globals.get_class_stats(level)
  Store.player.hp_max = class_stats.max_hp
  Store.player.mp_max = class_stats.max_mp
  Store.player.hp = Store.player.hp_max
  Store.player.mp = Store.player.mp_max

  Store.player.exper_max = 100

  self._update_ui()

func _update_ui():
  stats.hp_max = Store.player.hp_max
  stats.mp_max = Store.player.mp_max
  stats.hp = Store.player.hp
  stats.mp = Store.player.mp
  stats.iExp_max = Store.player.exper_max

func update_exp():
  stats.iExp = Store.player.exper

func _exp_change(e,percent,income):
  if percent >=100:
    Store.player.level_up()
    update_exp()
  update_player()

func _exit_tree() -> void:
  queue_free()

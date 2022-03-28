extends Node2D

onready var game = $ctx/game

var globals:Globals = Globals.new()

func _ready() -> void:
  setup_stats()
  game.update_ui()
  var cd = CoolDown.new("cd1",1)
  add_child(cd)
  cd.start()
  yield(cd,"done")
  Store.player.taken_damage(3)
  game.update_ui()
  pass # Replace with function body.

func setup_stats():
  var level = Store.player.level
  var class_stats:Dictionary = globals.get_class_stats(level,Store.player.class_type)
  Store.player.hp_max = class_stats.max_hp
  Store.player.mp_max = class_stats.max_mp
  Store.player.iExp_max = globals.get_exp_by_level(level)
  Store.player.iExp = 0
  Store.player.level_up()

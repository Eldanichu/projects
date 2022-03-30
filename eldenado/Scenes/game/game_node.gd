extends Node2D

onready var game = $window_ui/game_control

var globals:Globals = Globals.new()

func _ready() -> void:
  setup_stats()
  game.update_ui()

func setup_stats():
  var level = Store.player.level
  var class_stats:Dictionary = globals.get_class_stats(level,Store.player.class_type)
  Store.player.hp_max = class_stats.max_hp
  Store.player.mp_max = class_stats.max_mp
  Store.player.iExp_max = globals.get_exp_by_level(level)
  Store.player.iExp = 0
  Store.player.level_up()

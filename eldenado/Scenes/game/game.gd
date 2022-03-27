extends Control

onready var blur_bg = $blur
onready var game_setting = $game_setting

onready var stats = find_node('stats')

var globals:Globals = Globals.new()

func _ready() -> void:
  Logger.debug('game ready')
  setup()

func setup():
  hide_ui_without_game()
  stats.level = 1
  update_stats()
  init_stats()
  stats.connect("exp_change",self,"_exp_change")


func update_stats():
  var level = stats.level
  var class_stats:Dictionary = globals.get_class_stats(level,Store.player.class_type)
  stats.hp_max = class_stats.max_hp
  stats.mp_max = class_stats.max_mp
  stats.iExp_max = globals.get_exp_by_level(level)

func init_stats():
  stats.player_name = Store.player.player_name
  stats.class_type = Store.player.class_type
  stats.hp = stats.hp_max
  stats.mp = stats.mp_max
  stats.iExp = 0

func level_up():
  stats.level = stats.level + 1

func hide_ui_without_game():
  game_setting.visible = false
  set_blur(false)

func set_blur(show:bool = false):
  blur_bg.set_visible(show)

func pause_game(is_pause):
  get_tree().paused = is_pause

func ui_keys_control():
   if Input.is_action_pressed("ui_pause"):
      game_setting.visible = !game_setting.visible
      var _visible = game_setting.visible
      set_blur(_visible)
      pause_game(_visible)

func _exp_change(e,percent,income):
  if percent >= 100:
    level_up()
    update_stats()
    init_stats()
  pass

func _input(event: InputEvent) -> void:
    if event as InputEventKey:
      if event.is_pressed():
       ui_keys_control()

func _exit_tree() -> void:
  queue_free()

func _on_game_setting_close() -> void:
  set_blur(false)
  pause_game(false)

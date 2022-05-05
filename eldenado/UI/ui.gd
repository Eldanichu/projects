extends Control

onready var game_setting = $game_setting

onready var stats = find_node('stats')

func _ready() -> void:
  Logger.debug('game ready')
  setup()

func setup():
  hide_ui_without_game()
  bind_events()
  Store.player.setup_char_props()
  Store.player.level_up()
  update_ui()

func bind_events():
  stats.connect("exp_change",self,"_exp_change")

func hide_ui_without_game():
  game_setting.visible = false

func update_ui():
  stats.player_name = Store.player.player_name
  stats.level = Store.player.level
  stats.class_type = Store.player.class_type
  stats.hp_max = Store.player.hp_max
  stats.hp = Store.player.hp
  stats.mp_max = Store.player.mp_max
  stats.mp = Store.player.mp
  stats.iExp = Store.player.iExp
  stats.iExp_max = Store.player.iExp_max


func _exp_change(e,percent,income):
  if percent >= 100:
    Store.player.level_up()
    update_ui()

func _input(event: InputEvent) -> void:
    if event as InputEventKey:
      if event.is_pressed():
       ui_keys_control()

func ui_keys_control():
   if Input.is_action_pressed("ui_pause"):
      game_setting.visible = !game_setting.visible
      var _visible = game_setting.visible
      pause_game(_visible)

func pause_game(is_pause):
  get_tree().paused = is_pause

func _on_game_setting_close() -> void:
  pause_game(false)

func _exit_tree() -> void:
  queue_free()

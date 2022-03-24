extends Control

var ani_menu_fade_in:AnimationPlayer
var game:PackedScene = preload("res://Scenes/game/game.tscn")

func _ready() -> void:
  ani_menu_fade_in = $ani_fade_in
  ani_menu_fade_in.play("fade_in")
  pass

func _exit_tree() -> void:
  ani_menu_fade_in.clear_caches()
  ani_menu_fade_in.clear_queue()
  ani_menu_fade_in.queue_free()
  queue_free()


func _on_start_game_pressed() -> void:
  ani_menu_fade_in.play_backwards("fade_in")
  yield(ani_menu_fade_in,"animation_finished")
  get_tree().change_scene_to(game);
  pass # Replace with function body.


func _on_load_game_pressed() -> void:
  pass # Replace with function body.


func _on_game_settings_pressed() -> void:
  pass # Replace with function body.


func _on_quit_game_pressed() -> void:
  pass # Replace with function body.

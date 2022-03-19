extends Control

var ani_menu_fade_in:AnimationPlayer



func _ready() -> void:
  ani_menu_fade_in = $ani_fade_in
  ani_menu_fade_in.play("fade_in")
  pass

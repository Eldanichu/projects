extends Control

onready var stats = $m/vbox/top/stats
var rnd = RandomNumberGenerator.new()

func _on_hp_desc_pressed() -> void:
  rnd.randomize()
  stats.hp = stats.hp - rnd.randi_range(1,5)
  pass # Replace with function body.


func _on_hp_restore_pressed() -> void:
  stats.hp = stats.hp_max
  pass # Replace with function body.


func _on_exp_inc_pressed() -> void:
  rnd.randomize()
  stats.iExp = stats.iExp + rnd.randi_range(10,50)
  pass # Replace with function body.

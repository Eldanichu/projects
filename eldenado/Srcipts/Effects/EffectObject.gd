extends Node
class_name EffectObject

onready var timer:ATimer = ATimer.new(self)

var target:Node
var count = 0
var amount = 5

func _init(target_, effect_name) -> void:
	target = target_

func _ready() -> void:
	timer.connect("timeout", self, "_on_tick")
	timer.Interval = 1
	timer.start_timer()

func has_target():
	return target != null

func _on_tick():
	if count < amount:
		print(count)
		if self.has_method("_to_monster"):
			call("_to_monster",target)
		if self.has_method("_to_player"):
			call("_to_player",target)
		count += 1
		timer.start_timer()
	else:
		count = 0
		target.remove_child(self)

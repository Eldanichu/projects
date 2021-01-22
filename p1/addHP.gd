extends Button

signal addStats(Stats);

func _ready():
	pass
	
func _on_button_pressed():
	var stats :=Stats.new();
	stats.set_hp(300,600)
	emit_signal("addStats",stats);

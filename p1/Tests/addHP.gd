extends Button

signal addStats();

func _ready():
    pass
    
func _on_button_pressed():
    emit_signal("addStats");

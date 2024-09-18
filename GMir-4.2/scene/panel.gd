extends Panel

@onready var label: Label = %label
@onready var scroll_container: ScrollContainer = %scroll_container

var text_len = 0
var last_chart_pos
var reverse = false
func _ready() -> void:
	text_len = label.get_total_character_count()
	last_chart_pos = max(0, label.size.x - scroll_container.size.x)

	
func _physics_process(delta: float) -> void:
	var v = scroll_container.get_h_scroll_bar().value
	if not reverse:
		scroll_container.get_h_scroll_bar().value += 1
	else:
		scroll_container.get_h_scroll_bar().value -= 1

	if(v >= last_chart_pos):
		reverse = true
	if(v <= 0):
		reverse = false

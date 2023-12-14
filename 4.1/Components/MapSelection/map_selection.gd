extends PanelContainer

signal map_click(id,name_str)

@onready var btn_container = $tab_container/M1/btn_container

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = btn_container.get_children()
	for btn in children:
		btn.pressed.connect(emit.bind(btn.name,btn.text))

func emit(id,name_str):
	emit_signal("map_click",id,name_str)


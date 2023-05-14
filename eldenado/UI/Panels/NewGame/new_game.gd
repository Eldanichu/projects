extends Panel

onready var player_name = get_node('%input_name')
onready var class_buttons := $"%class_buttons"
onready var player_class = $"%Warrior"

func _ready():
	var class_btns = class_buttons.get_children()
	for b in class_btns:
		b.connect("pressed",self,"class_link_audio")

func _on_create_player_pressed() -> void:
	emit_audio()
	var result = {
			"player_name":player_name.text,
			"class_type":get_selected_class()
	 }
	if StringUtil.isEmptyOrNull(result["player_name"]):
		return
	elif result["class_type"] == -1:
		return
	Event.emit_signal("create_game",result)
	queue_free()

func _on_cancel_pressed() -> void:
	emit_audio()
	queue_free()

func get_selected_class() -> int:
	var g:ButtonGroup = player_class.get_button_group()
	var selected = g.get_pressed_button()
	if !selected:
		return -1
	return Globals.CLASS_TYPE[selected.name]

func emit_audio():
	Event.emit_signal(Event.BUTTON_AUDIO.BUTTON)

func class_link_audio():
	Event.emit_signal(Event.BUTTON_AUDIO.LINK)

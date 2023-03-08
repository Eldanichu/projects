extends Panel

onready var player_name = get_node('%input_name')
onready var player_class = get_node('%class')
signal _on_create_game(result)

func _ready() -> void:
	pass

func _on_create_player_pressed() -> void:
	var result = {
		"success":false,
		"msg":"玩家名称"
		}
	var _player_name = player_name.text

	if StringUtil.isEmptyOrNull(_player_name):
		emit_signal("_on_create_game",result)
		return
	var _class_type = get_selected_class()
	result = {
			"success":true,
			"class_type":_class_type,
			"player_name":_player_name
	 }
	emit_signal("_on_create_game",result)

func _on_cancel_pressed() -> void:
	visible = false

func get_selected_class() -> int:
	var g:ButtonGroup = player_class.get_button_group()
	var selected = g.get_pressed_button()
	return Globals.ClassType[selected.name]

func validator() -> bool:
	return true

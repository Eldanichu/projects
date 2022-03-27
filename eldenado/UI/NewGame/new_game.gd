extends Panel

onready var player_name = find_node('input_player_name')
onready var player_class = find_node('class')

signal create
signal cancel


func _on_set_class(pressed):
  var g:ButtonGroup = player_class.get_button_group()
  var selected = g.get_pressed_button()
  Store.player.class_type = Globals.ClassType[selected.name]
  pass


func _on_input_player_name_text_changed(new_text: String) -> void:
  Store.player.player_name = new_text


func _on_create_player_pressed() -> void:
  var _text = player_name.text
  if _text == null or _text.strip_escapes() == "":
    return
  visible = false
  emit_signal("create")


func _on_cancel_pressed() -> void:
  emit_signal("cancel")
  pass # Replace with function body.

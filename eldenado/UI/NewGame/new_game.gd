extends CanvasLayer

onready var player_name = get_node('%input_name')
onready var player_class = get_node('%class')

signal create(info)
signal cancel

func get_selected_class() -> int:
  var g:ButtonGroup = player_class.get_button_group()
  var selected = g.get_pressed_button()
  return Globals.ClassType[selected.name]


func _on_create_player_pressed() -> void:
  var _text = player_name.text
  if _text == null or _text.strip_escapes() == "":
    return
  var _class_type = get_selected_class()
  var info = {
      "c_class":_class_type,
      "c_name":_text
   }
  emit_signal("create",info)

func _on_cancel_pressed() -> void:
  emit_signal("cancel")

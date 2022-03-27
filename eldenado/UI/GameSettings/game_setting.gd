extends Panel

signal close

onready var resolution_options:OptionButton = find_node('resolution_options')

var is_full_screen = false
var is_verticle_sync = false

func _ready() -> void:

  pass

func close_dialog():
  visible = false
  emit_signal("close")

func gui_input(event: InputEvent) -> void:
  if get_tree().paused:
    if event as InputEventKey:
      if event.is_pressed():
        if Input.is_action_pressed("ui_pause"):
          visible = !visible
          close_dialog()

func _on_close_pressed() -> void:
  close_dialog()
  pass # Replace with function body.


func _on_is_full_screen_toggled(button_pressed: bool) -> void:
  is_full_screen = button_pressed
  pass # Replace with function body.


func _on_save_pressed() -> void:
  OS.set_window_fullscreen(is_full_screen)
  pass # Replace with function body.


func _on_is_verticle_sync_toggled(button_pressed: bool) -> void:
  is_verticle_sync = button_pressed
  OS.set_use_vsync(is_verticle_sync)
  pass # Replace with function body.

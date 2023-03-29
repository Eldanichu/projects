extends Panel

onready var resolution_options:OptionButton = find_node('resolution_options')
onready var chk_fullscreen := $container/m/scroll_container/col_1/left/is_full_screen
onready var chk_v_sync := $container/m/scroll_container/col_1/left/is_verticle_sync

var is_full_screen = false
var is_verticle_sync = false

func _ready() -> void:
	chk_fullscreen.pressed = Store.settings.fullscreen
	chk_v_sync.pressed = Store.settings.v_sync
	pass

func close_dialog():
	queue_free()

func _on_close_pressed() -> void:
	close_dialog()

func _on_is_full_screen_toggled(button_pressed: bool) -> void:
	is_full_screen = button_pressed
	Store.settings.fullscreen = button_pressed

func _on_is_verticle_sync_toggled(button_pressed: bool) -> void:
	is_verticle_sync = button_pressed
	Store.settings.v_sync = button_pressed

func _on_save_pressed() -> void:
	OS.set_window_fullscreen(is_full_screen)
	OS.set_use_vsync(is_verticle_sync)

	close_dialog()

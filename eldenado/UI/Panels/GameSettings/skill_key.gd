extends HBoxContainer

onready var label := $"%label"
onready var key_name := $"%key_name"
onready var button := $"%button"

var _label:String = "-"
var _key_name:String = "-"

var is_setting_key:bool = false
var blink_time:float = 0.0
var blink_speed:float = 3

var tween:Tween = Tween.new()

func _ready() -> void:
	add_child(tween);
	setup()
	pass

func _process(delta: float) -> void:
	text_blink(delta)
	label.text = _label
	key_name.text = _key_name

func _input(event) -> void:
	keyboard_bindings(event)
	mouse_key_bindings(event)

func mouse_key_bindings(event):
	if not event as InputEventMouseButton || !is_setting_key:
		return
	if event.is_pressed():
		var _key = event.button_index
		if _key == 1:
			set_to_key(_key, "LMB")
		elif _key == 2:
			set_to_key(_key, "RMB")

func keyboard_bindings(event):
	if not event as InputEventKey || !is_setting_key:
		return
	if event.is_pressed():
		var key = event.scancode
		var key_str = OS.get_scancode_string(key)
		if clear_key(key):
			return
		set_to_key(key, key_str)

func clear_key(key):
		if key == KEY_ESCAPE:
			set_to_key(-1, "-")
			return true
		return false

func setup():
	label.text = "-"
	key_name.text = "-"
	button.connect("button_up",self,"_on_setting_key")

func set_to_key(key_code, key_str):
	if not is_instance_valid(Store) and not "settings" in Store:
		print("Game Setting Class is not in AutoLoad.")
		return
	var settings = Store.settings
	_key_name = key_str
	is_setting_key = false
	var _name = label.text
	if not _name in settings.key_bindings:
		return
	settings.key_bindings[_name]["key_code"] = key_code
	settings.key_bindings[_name]["key"] = key_str
	print("[Key Bindings] The Key that binds to key code:",key_code,"----Key:",key_str)

func text_blink(delta:float):
		if not is_setting_key:
			button.text = "Press to Set"
			tween_alpha(1)
			return
		blink_time += delta
		if blink_time <= blink_speed:
			tween_alpha(0.4)
		else:
			blink_time = 0

func tween_alpha(alpha):
	if tween.is_active():
		return
	tween.interpolate_property(
		button,
		"modulate:a",
		modulate.a,
		alpha,
		0.3,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)
	tween.start()

func _on_setting_key():
	button.text = "Press ESC to Clear"
	is_setting_key = true

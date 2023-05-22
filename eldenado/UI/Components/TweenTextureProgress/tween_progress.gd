extends Control

export(String) var t_val = "0"
export(String) var t_max = "100"
var duration = 0.2
export(Texture) var texture
export(Texture) var under
export(bool) var show_value = true
export(Color) var value_color = Color.white
export(int,7,72) var font_size = 14

onready var pg:TextureProgress = $"%pg"
onready var lbl_text:Label = $"%text"

var tween:Tween = Tween.new()
var value:float = 0

func _ready() -> void:
	setup()

func _process(delta: float) -> void:
	update_values()
	if tween.is_active():
		return
	update_progress()

func setup():
	add_child(tween)
	pg.texture_progress = texture
	pg.texture_under = under
	lbl_text.visible = show_value
	lbl_text.set("custom_colors/font_color",value_color)
	lbl_text.set("custom_fonts/font/size",font_size)

func update_values():
	lbl_text.text = "{0}/{1}".format([t_val,t_max])

func update_progress():
	pg.max_value = 100
	var _t_max = float(t_max)
	var _t_val = float(t_val)

	if _t_max <= 0:
		return

	var _percent = GameUtils.get_percent(_t_val,_t_max)
	tween.stop_all()
	tween.interpolate_property(
		pg,
		"value",
		pg.value,
		_percent,
		0.2,
		Tween.TRANS_CUBIC,
		Tween.EASE_IN_OUT
	)
	tween.start()

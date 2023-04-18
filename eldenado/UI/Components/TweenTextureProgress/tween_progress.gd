extends Control
class_name TweenProgress

export(String) var t_val = "0" setget set_t_val
export(String) var t_max = "1" setget set_t_max
var duration = 0.2
export(Texture) var texture
export(Texture) var under
export(bool) var show_value = true
export(bool) var use_tween = true
export(Color) var value_color = Color.white

onready var pg:TextureProgress = $"%pg"
onready var lbl_text:Label = $"%text"
onready var tween_pg:Tween = $"%tween_pg"

func _ready() -> void:
	setup()

func setup():
	pg.texture_progress = texture
	pg.texture_under = under
	lbl_text.visible = show_value
	lbl_text.set("custom_colors/font_color",value_color)

func update_values():
	lbl_text.text = "{0}/{1}".format([t_val,t_max])

func update_progress():
	pg.max_value = 100
	var _t_max = float(t_max)
	var _t_val = float(t_val)

	if _t_max <= 0:
		return

	var _percent = _t_val / _t_max * 100
	if !use_tween:
		pg.value = _percent
		return
	tween_pg.stop_all()
	tween_pg.interpolate_property(
		pg,
		"value",
		pg.value,
		_percent,
		duration,
		Tween.TRANS_QUINT,
		Tween.EASE_IN_OUT
	)
	tween_pg.start()

func value_change():
	if not is_inside_tree():
		return
	update_values()
	update_progress()

func set_t_val(v):
	t_val = v
	value_change()

func set_t_max(v):
	t_max = v
	value_change()

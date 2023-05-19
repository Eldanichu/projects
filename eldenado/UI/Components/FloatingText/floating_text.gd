extends Position2D

onready var _label := $"%label"
var d = 5.0
var start_d = 0.0

var t := Tween.new()
var r := RandomNumberGenerator.new()
var label = 0
var floatting = true

func _ready() -> void:
	r.randomize()
	t.repeat = false
	t.connect("tween_all_completed",self,"_on_float_away")
	add_child(t)
	pass

func _process(delta: float) -> void:
	_label.text = str(label)
	if floatting:
		float_away(delta)
	scale_to_number()

func _on_float_away():
	t.stop_all()
	floatting = false
	queue_free()

func float_away(delta):
	start_d += delta
	if start_d <= d:
		position.y -= d
	if t.is_active():
		return
	t.interpolate_property(
		self,
		"scale",
		scale,
		scale * r.randf_range(1.1,1.5),
		0.6,
		Tween.TRANS_QUART,
		Tween.EASE_IN_OUT
	)
	t.interpolate_property(
		self,
		"modulate:a",
		1,
		0,
		0.6,
		Tween.TRANS_QUART,
		Tween.EASE_IN_OUT
	)
	t.start()

func scale_to_number():
	pass

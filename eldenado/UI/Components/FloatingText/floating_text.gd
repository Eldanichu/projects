extends Position2D

onready var _label := $"%label"
var d = 2
var start_d = 0.0
var t_pos = Vector2.ZERO

var t := Tween.new()
var r := RandomNumberGenerator.new()
var label = 0
var floatting = true

func _ready() -> void:
	r.randomize()
	t.repeat = false
	t.connect("tween_all_completed",self,"_on_float_away")
	add_child(t)
	t_pos = Vector2(position.x - 30,position.y - 30)
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

func _cubic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float):
		var q0 = p0.linear_interpolate(p1, t)
		var q1 = p1.linear_interpolate(p2, t)
		var q2 = p2.linear_interpolate(p3, t)

		var r0 = q0.linear_interpolate(q1, t)
		var r1 = q1.linear_interpolate(q2, t)

		var s = r0.linear_interpolate(r1, t)
		return s

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

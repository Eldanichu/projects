extends Control

export(int,"Top Left","Top Right","Bottom Center") var side:int = 2
export(float) var offset:float = 10.0
export(float) var y_offset:float = 10.0

export(float) var duration:float = 1.5
export(int) var delay:int = 3
export(String) var msg = "hi"

enum NOTIFY_POSITION {
	TOP_LEFT = 0,
	TOP_RIGHT = 1,
	BOTTOM_CENTER = 2
}

var notify_id := ""
var rnd:RandomNumberGenerator = RandomNumberGenerator.new()

var screen_size:Vector2
var control_size:Vector2
var positions:Array

var fade_in:Tween = Tween.new();
var _shadow_offset = 0

onready var panel := $panel
onready var _msg := $"%msg"

func _ready() -> void:
	setup()
	start_animation()
	dispose()


func setup()->void:
	rnd.randomize()
	notify_id = str(rnd.randi_range(1000,9999))
	add_child(fade_in)
	var styles = panel.get_stylebox("notify")
	_shadow_offset = styles.get_offset().x
	_msg.text = str(msg)
	screen_size = OS.get_window_size()
	control_size = Vector2(rect_size.x - _shadow_offset, rect_size.y - _shadow_offset)
	positions = [
		Vector2(
			offset,
		 offset + y_offset
		),

		Vector2(
			screen_size.x - control_size.x - _shadow_offset - offset,
		offset + y_offset
		),

		Vector2(
			screen_size.x * 0.5 - control_size.x * 0.5,
		 screen_size.y - control_size.y - offset - y_offset
		)
	]

func start_animation()->void:
	var start_position
	if side == NOTIFY_POSITION.TOP_LEFT:
		start_position =  Vector2(-control_size.x, offset)
	elif side == NOTIFY_POSITION.TOP_RIGHT:
		start_position =  Vector2(screen_size.x , offset)
	elif side == NOTIFY_POSITION.BOTTOM_CENTER:
		start_position =  Vector2(-control_size.x , screen_size.y - control_size.y - offset)

	rect_global_position = start_position
	fade_in.interpolate_property(self,
		"modulate:a",
		0,
		1,
		duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	fade_in.interpolate_property(self,
		"rect_position",
		start_position,
		positions[side],
		duration,
		Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT
	)
	fade_in.start()

func dispose()->void:
	yield(fade_in, "tween_all_completed")
	yield( get_tree().create_timer(delay,true), "timeout")
	fade_in.interpolate_property(self,
			"modulate:a",
			1,
			0,
			0.5,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)
	fade_in.start()
	yield(fade_in, "tween_all_completed")
	queue_free()

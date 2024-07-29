extends Node
class_name TimerEx

signal on_tick(delta)
signal on_counting(count)
signal on_timeout()
signal on_paused()

@export
var loop:bool = false
@export
var times:int = 0
@export
var interval:float = 1.0

var timer:Timer
var paused:bool = true
var delta:float = 0.0
var count:int = 0
var is_new_turn:bool = false

func _init(node:Node):
	reset()
	if not node:
		return
	timer = Timer.new()
	timer.autostart = false;
	timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	timer.timeout.connect(_on_timeout)
	node.add_child(self)
	add_child(timer)

func start():
	var _is_out_of_time = out_of_times()
	var _is_infinite = is_infinite()
	if _is_out_of_time and (not _is_infinite):
		pause()
		_emit(0)
		return

	var delta_zero = is_equal_approx(delta, 0.0)
	if not delta_zero:
		timer.wait_time = delta
	else:
		timer.wait_time = interval
	paused = false
	timer.start()

func pause():
	if timer:
		timer.stop()
	paused = true

func set_time_scale(scale:float):
	pause_and_emit()
	delta = delta * scale
	timer.wait_time = delta
	start()

func set_time_value(value:float):
	pause_and_emit()
	delta = max(0, delta - value)
	if is_zero_approx(delta):
		timer.wait_time = interval
	else:
		timer.wait_time = delta
	start()

func pause_and_emit():
	pause()
	_emit(delta)

func reset():
	reset_count()
	pause()
	_reset_delta()
	_emit(delta)

func clear():
	if timer:
		timer.queue_free()
	queue_free()

func _on_timeout():
	if hard_timeout():
		return
	_reset_delta()
	_emit_timeout()
	_emit(delta);
	loop_timer()

func loop_timer():
	if loop:
		inc_count()
		if is_new_turn:
			timer.wait_time = interval
			#print("new turn interval->" + str(interval))
		start()
	else:
		pause()
		_emit(0)

func _reset_delta():
	delta = 0

func _emit(_delta:float):
	delta = _delta
	emit_signal("on_tick",delta)

func _emit_timeout():
	emit_signal("on_timeout")

func _physics_process(_delta):
	if hard_timeout() or out_of_times():
		return
	delta = timer.time_left
	_emit(delta)

func hard_timeout() -> bool:
	return paused || timer.is_stopped()

func inc_count():
	count = count + 1
	is_new_turn = true
	emit_signal("on_counting", count)

func reset_count():
	count = 0

func out_of_times():
	return count >= times and times != 0

func is_infinite():
	return times <= 0

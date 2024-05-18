extends Node
class_name TimerEx

signal on_tick(delta)
signal on_timeout()
signal on_paused()

@export
var loop:bool = true
@export
var tick:bool = false
@export
var interval:float = 1.0

var timer:Timer
var duration:float = 0.0
var paused:bool = true
var delta:float = 0.0

func _init(node:Node):
	paused = true
	_emit(0)
	if node:
		timer = Timer.new()
		timer.autostart = false;
		timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
		timer.timeout.connect(_on_timeout)
		node.add_child(self)
		add_child(timer)

func set_time_scale(scale:float):
	if delta <= 0:
		return
	pause_and_emit()
	delta = delta * scale
	timer.wait_time = delta
	start(true)

func start(scaled:bool = false):
	reset()
	if not paused && not soft_timeout():
		return
	paused = false
	if not scaled:
		timer.wait_time = interval
	if not tick:
		duration = interval
		_emit(delta)
	timer.start()

func pause():
	timer.stop()
	paused = true

func pause_and_emit():
	pause()
	_emit(delta)

func reset():
	pause()
	_reset_delta()
	_emit(delta)

func clear():
	if timer:
		timer.queue_free()
	queue_free()

func _on_timeout():
	if not tick:
		duration = interval
		timer.wait_time = interval
	if paused:
		return
	if duration <= 0 and tick:
		_emit(-1)
		timer.start()
		return
	if hard_timeout():
		_reset_delta()
		emit_signal("on_timeout")
		_emit(delta);
		if loop:
			timer.start()
			return
		pause()
		
	_emit(delta);
	
	if not loop:
		pause()
		_emit(0)

func _reset_delta():
	delta = 0

func _emit(_delta:float):
	delta = _delta
	emit_signal("on_tick",delta)

func _physics_process(_delta):
	if tick:
		return
	if paused:
		return
	delta = timer.time_left
	_emit(delta)

func hard_timeout() -> bool:
	return soft_timeout() || not timer.is_stopped()

func soft_timeout() -> bool:
	return delta >= duration

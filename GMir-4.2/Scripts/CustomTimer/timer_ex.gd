extends Node
class_name TimerEx

signal on_tick(delta)
signal on_timeout()
signal on_paused()

@export
var duration:float = 0.0

@export
var interval:float = 1.0

@export
var tick:bool = false
@export
var loop:bool = true

var timer:Timer

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

func _emit(_delta:float):
	delta = _delta
	emit_signal("on_tick",delta)

func _process(_delta):
	if tick:
		return
	if paused:
		return
	delta = timer.time_left
	_emit(delta)

func set_time_scale(scale:float):
	if delta <= 0:
		return
	pause()
	delta = delta * scale
	timer.wait_time = delta
	start(true)

func start(scaled:bool = false):
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
	paused = true
	_emit(delta)
	timer.stop()

func reset():
	timer.stop()
	paused = true
	delta = 0
	_emit(delta)

func clear():
	if timer:
		timer.queue_free()
	queue_free()

func _on_timeout():
	duration = interval
	if paused:
		return
	if duration <= 0 && tick:
		_emit(-1)
		timer.start()
		return
	if hard_timeout():
		timer.stop()
		paused = true
		delta = 0
		emit_signal("on_timeout")
	_emit(delta);
	if not loop:
		paused = true
		timer.stop()
		_emit(0)
		return
	
	timer.start()

func hard_timeout() -> bool:
	return soft_timeout() || not timer.is_stopped()

func soft_timeout() -> bool:
	return delta >= duration

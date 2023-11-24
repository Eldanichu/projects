extends Node
class_name TimerEx

signal on_tick(delta)

@export
var duration:float = 0.0

@export
var interval:float = 1

var timer:Timer = Timer.new()

var paused:bool = true
var delta:float = 0

func _init(node:Node):
	paused = true
	timer.autostart = false;
	timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	timer.timeout.connect(_on_timeout)
	_emit(0)
	if node:
		node.add_child(timer)

func _emit(d):
	delta = d
	emit_signal("on_tick",delta)

func start():
	if not paused && not _is_timeout():
		return
	paused = false
	timer.wait_time = interval
	timer.start()

func pause():
	paused = true
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
	if paused:
		return
	if duration <= 0:
		_emit(-1)
		timer.start()
		return
	if _is_timeout():
		timer.stop()
		paused = true
	_emit(delta);
	delta = delta + 1
	timer.start()

func _is_timeout() -> bool:
	return delta >= duration

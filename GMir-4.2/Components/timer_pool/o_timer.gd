extends Node
class_name OTimer

signal on_update(dt,p)
signal on_tick(ticks)
signal timeout()

var interval:float = 5.0
var max_tick:int = 1
var paused:bool = false
var update:Callable

var _tick:int = 0
var _tick_internal:int
var _dt:float = 0
var _dt_pad:float = 0
var _dtp:float = 0

func _init() -> void:
	_tick_internal = max_tick
	_callback(_dt)
	pause()
	
func _process(delta: float) -> void:
	if paused:
		return
	if _timer_end() and _timer_stopped():
		emit_signal("on_update", 0, 0)
		return
	if _cap_on_tick() and not _unlimited_tick():
		_dt = 0
		_tick = 0
		_pad_to_interval()
		emit_signal("on_update", 0, 0)
		return
	if _timeout():
		_dt = 0
		_tick = _tick + 1
		_emit_tick(_tick)
		_emit_timeout()
		_pad_to_interval()
		emit_signal("on_update", 0, 0)
		return
	if not _timer_stopped():
		_dt = delta * 1.000000 + _dt
		_callback(_dt)

func start():
	_dt = 1

func restart():
	_tick = 0
	paused = false
	max_tick = _tick_internal
	start()

func pause():
	paused = true
func resume():
	paused = false
func stop():
	_dt = 0
	_tick_internal = max_tick
func scale(s:float, raw:bool = false):
	if is_zero_approx(s) or s < 0:
		return
	var _amount
	if raw:
		_amount = _dt - s
	elif s < 1:
		_amount = _dt - (_dt * s)
	elif s >= 1:
		_amount = _dt - s
	if _amount <= 0:
		_dt = 0

	_dt = _amount

func set_tick(s:int):
	if s <= 0:
		stop()
		return
	max_tick = s

func _timer_begin():
	return is_equal_approx(_dt, 1)
func _timer_end():
	return is_zero_approx(_dt)
func _timeout():
	return is_equal_approx(_dt, interval) or _dt >= interval
func _cap_on_tick():
	return _tick >= max_tick 
func _unlimited_tick():
	return max_tick == -1
func _timer_stopped():
	return (_cap_on_tick() or _timeout())
func _pad_to_interval():
	_dt_pad = interval
	_callback(_dt_pad)

func _emit_tick(ticks):
	emit_signal("on_tick",ticks)
func _emit_timeout():
	emit_signal("timeout")
func _callback(dt:float):
	_dtp = _dt / max(0, interval) * 100
	if not update.is_null() and update.is_valid():
		update.bindv([dt,_dtp]).call_deferred()
	emit_signal("on_update", dt, _dtp)
	
	
	
	
	
	

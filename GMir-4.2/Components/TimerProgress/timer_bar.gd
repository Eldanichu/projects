extends ProgressBar
class_name ActionProgress

signal ticking(count)
signal timeout()

@onready var timer:TimerTick = TimerTick.new(self)

@export
var interval:float = 0

func _ready():
	timer.on_tick.connect(_on_timer_tick)
	timer.on_counting.connect(_on_timer_counting)
	timer.on_timeout.connect(_on_timer_timeout)
	_percent(0)

func start():
	max_value = interval
	timer.set_interval(interval)
	timer.start()

func pause():
	timer.pause()

func restart():
	timer.reset()

func reduce_value(v):
	timer.set_time_value(v)

func reduce_scale(v):
	timer.set_time_scale(v)

func _on_timer_tick(delta:float):
	_percent(delta)

func _on_timer_counting(index:int):
	pass

func _on_timer_timeout():
	value = 0

func _percent(delta):
	var interval:float = interval
	var p = delta
	value = p

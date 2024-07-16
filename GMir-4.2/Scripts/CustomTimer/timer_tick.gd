extends TimerEx
class_name TimerTick

var ticking:Callable

func _init(node:Node):
	super(node)
	times = 0
	loop = true
	interval = 0.25

func set_interval(interval_:float):
	interval = interval_

func tick_method(callable:Callable):
	ticking = callable
	on_counting.connect(ticking)

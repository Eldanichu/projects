extends ProgressBar
class_name TweenProgress

@export_range(0.1,9,0.01) 
var duration:float = 0

@export_enum(
	"TRANS_CIRC",
	"TRANS_ELASTIC",  
	"TRANS_CUBIC"
	) 
var trans:String = "TRANS_CUBIC"


var v_min:float = 0
var v_max:float = 0
var tween:Tween
var percent:float = 0

var timer:TimerEx

func _ready():
	timer = TimerEx.new(self)
	timer.on_tick.connect(_on_tick)
	timer.tick = false

func start():
	max_value = 100;
	v_max = timer.interval
	timer.start()

func set_interval(val:float) -> TweenProgress:
	timer.interval = val
	v_min = val
	return self
	

func _on_tick(delta:float):
	v_min = delta
	print("on_tick->",delta)
	tween_progress()

func tween_progress():
	var _min_v = max(v_min,0)
	var _max_v = max(v_max,1)
	percent = min((_min_v / _max_v * 100), max_value)
	
	if tween:
		tween.kill()
	
	tween = create_tween() \
		.bind_node(self) \
		.set_parallel(true) \
		.set_trans(Tween[trans]) \
		.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)

	tween.parallel().tween_property(self, "value", percent ,duration)






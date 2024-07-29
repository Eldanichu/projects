extends ProgressBar
class_name ValueProgress

@export 
var v_min:float = 0:
	set(value):
		v_min = value
		F.await_tree(
			func():
				tween_progress()
		, self)
		

@export 
var v_max:float = 0:
	set(value):
		v_max = value
		F.await_tree(
			func():
				tween_progress()
		, self)

@export_range(0.1,9,0.01) 
var duration:float = 0.2

@export_enum(
	"TRANS_CIRC",
	"TRANS_ELASTIC",  
	"TRANS_CUBIC"
	) 
var trans:String = "TRANS_CUBIC"

var tween:Tween
var percent:float = 0

func _ready():
	tween_progress()
	pass

func tween_progress():
	max_value = 100;
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






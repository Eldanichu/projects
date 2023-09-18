extends TextureProgressBar
class_name TweenProgress

@export 
var v_min:float = 0:
	set(value):
		v_min = value
		tween_progress()

@export 
var v_max:float = 0:
	set(value):
		v_max = value
		tween_progress()

@export_range(0.1,9,0.01) 
var duration = 0.2

@export_enum(
	"TRANS_CIRC",
	"TRANS_ELASTIC",  
	"TRANS_CUBIC"
	) 
var trans = "TRANS_CUBIC"

var percent:float = 0

func _ready():
	pass

func tween_progress():
	max_value = 100;
	percent = max(v_min,0) / max(v_max,1) * 100

	var t = create_tween() \
		.bind_node(self) \
		.set_parallel(true)
	t.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS) \
		.set_trans(Tween[trans])
	t.parallel().tween_property(self, "value", percent ,duration)

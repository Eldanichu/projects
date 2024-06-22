extends ProgressBar
class_name StatBar

@export
var v:int:
	set(val_):
		v = val_
		call_deferred("set_progress")

@export
var vmax:int:
	set(val_):
		vmax = val_
		call_deferred("set_progress")

@onready var step_bar = %step_bar

var tween_inner:Tween

func _ready():
	start_tween_inner()

func set_progress():
	max_value = 100
	value = N.I2F(v) / max(N.I2F(vmax),1.00) * 100
	start_tween_inner()
	

func start_tween_inner():
	tween_inner = create_tween().bind_node(step_bar)
	tween_inner.set_trans(Tween.TRANS_CUBIC)
	tween_inner.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween_inner.parallel()
	tween_inner.tween_property(step_bar,"value",self.value,1.5)

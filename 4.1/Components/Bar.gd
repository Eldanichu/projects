extends TextureProgressBar

@export 
var v_min:float = 0

@export 
var v_max:float = 0:
	set(value):
		v_max = max(value,1)

var percent:float = 0

func _ready():
	pass 

func _process(delta):
	tween_progress()
	pass

func tween_progress():
	max_value = 100;
	percent = v_min / v_max * 100
	var t = create_tween() \
			.bind_node(self) \
			.set_parallel(true)
	t.parallel().tween_property(self,"value",percent,0.2)

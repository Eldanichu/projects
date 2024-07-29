extends ProgressBar
class_name BuffIndicator
@export
var percent:float:
	set(v):
		percent = v
		call_deferred("set_value",percent)

@export
var dt:float:
	set(v):
		dt = v

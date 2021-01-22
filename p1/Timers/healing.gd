extends Timer

signal healing(val);

var h_val=0
var _count = 0
var _ticks = 0

func setup(id:String,val:int,cd:float,ticks:int = 7):
	name = id;
	wait_time = cd;
	_ticks = ticks
	h_val = val

func _on_healing_timeout():
	if _count >= _ticks:
		queue_free()
	emit_signal("healing",h_val);
	_count = 1 + _count

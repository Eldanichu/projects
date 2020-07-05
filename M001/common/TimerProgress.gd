extends Node

onready var pb = $ProgressBar;

export var interval:int = 0
export var inv:float = -1



func _ready():
	if inv == null or inv == -1: return;
	var _timer  = Timer.new()
	_timer.set_autostart(true)
	add_child(_timer)
	
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_timer_process_mode(Timer.TIMER_PROCESS_PHYSICS)
	_timer.set_wait_time(inv)
	_timer.set_one_shot(false) # Make sure it loops
	


func _on_Timer_timeout():
	interval = interval + 1
	pb.value = interval

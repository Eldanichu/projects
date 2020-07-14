extends Node
class_name ct

static func addTimer(interval,target,funcName):
	if interval == null or interval == -1: return;
	var _timer  = Timer.new()
	_timer.set_autostart(true)
	target.add_child(_timer)
	
	_timer.connect("timeout", target, funcName)
	_timer.set_timer_process_mode(Timer.TIMER_PROCESS_PHYSICS)
	_timer.set_wait_time(interval)
	_timer.set_one_shot(false) # Make sure it loops

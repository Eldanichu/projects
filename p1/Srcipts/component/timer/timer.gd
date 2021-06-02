extends Timer
class_name CoolDown

signal cooling_down()
signal cd_ready()

var is_ready:bool = false;
export(float) var cooldown:float = 3;
export(bool) var idle:bool = true;

func _init():
	self.wait_time = cooldown;
	self.connect("timeout",self,"_on_timeout")

func _process(delta):
	if time_left < 0:
		return;
	is_ready = false;
	emit_signal("cooling_down",time_left)


func _on_timeout():
	emit_signal("cd_ready")
	is_ready = true;
	self.stop();
	if not idle:
		return;
	if not is_ready or idle:
		self.start();

func _exit_tree():
	queue_free();

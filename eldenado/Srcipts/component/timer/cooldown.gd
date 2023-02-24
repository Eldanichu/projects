extends Timer
class_name CoolDown

signal cooldown(value)
signal done(ready)

var is_ready:bool = false
var reduce_amount:float = 0.0

export(float) var cooldown:float = 0
export(bool) var idle:bool = false

func _init(id:String, p_cd:float = cooldown):
	self.set_unique_name_in_owner(true)
	self.name = id
	if(p_cd > 0):
		cooldown = p_cd
	self.set_wait_time(cooldown)
	self.set_autostart(true)
	var err = self.connect("timeout",self,"_on_timeout")
	if err != OK:
		print_debug('timer event is not correct')


func _process(delta):
	if has_remining():
		return
	update()

func update():
	set_ready(false)
	reduce_cooldown()
	emit_signal("cooldown", "%.2f" % self.time_left)

func has_remining():
	return self.time_left <= 0.00

func reduce_cooldown():
	if(reduce_amount > 0):
		var amount = time_left - reduce_amount
		if amount >= 0:
			self.set_wait_time(amount)
			self.start()
			reduce_amount = 0

func _on_timeout():
	if !restart():
		finish()

func restart():
	if not isIdle():
		queue_free()
		return false
	if not is_ready or isIdle():
		self.set_wait_time(cooldown)
		self.start()
		return true

func finish():
	set_ready(true)
	self.stop()
	emit_signal("done",is_ready)

func isIdle() -> bool:
	return idle

func set_reduce_amount(value:float):
	if value == null or value <= 0:
		reduce_amount = 0
	reduce_amount = value

func set_ready(reday:bool):
	is_ready = reday

func _exit_tree() -> void:
	queue_free();

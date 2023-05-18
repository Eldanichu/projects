extends Button

export(float) var interval = 0

onready var progress := $"%progress"

var timer:ATimer = ATimer.new(self)

func _ready():
	connect("button_down",self, "_on_press")
	timer.connect("remains",self,"_on_timing")
	timer.connect("timeout",self,"_on_timeout")
	timer.Interval = interval
	progress.max_value = 100
	progress.value = 0


func _process(delta):
	if interval == 0:
		interval = -1
	if progress.value <= 0:
		progress.mouse_filter = MOUSE_FILTER_PASS
	if progress.value > 0:
		progress.mouse_filter = MOUSE_FILTER_STOP

func _on_press():
	if timer.is_stopped() && !disabled:
		timer.start_timer()

func _on_timing(time_left):
	progress.value = GameUtils.get_percent(time_left, interval)


func _on_timeout():
	timer.stop()


extends Control

@onready var label := %L

@onready
var timer = TimerEx.new(self);

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.duration = 30
	timer.interval = 0.2
	timer.on_tick.connect(on_tick)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_tick(d):
	count = count + 1
	label.text = str(d)
	pass

func _on_start_pressed():
	timer.start()
	pass # Replace with function body.


func _on_pause_pressed():
	timer.pause()
	pass # Replace with function body.


func _on_stop_pressed():
	timer.reset()
	pass # Replace with function body.

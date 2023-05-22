extends Node2D

export(float,0.2,5) var match_delay = 1

export(int,2,20) var min_keys_for_matching = 5

const QUEUE_SIZE = 24
const QUENED_KEYS = [
	KEY_0,
	KEY_1,
	KEY_2,
	KEY_3,
	KEY_4,
	KEY_5,
	KEY_6,
	KEY_7,
	KEY_8,
	KEY_9,
	KEY_0
]

class Quene:

	var keys:Array = []
	var size:int
	var current_key
	var last_key
	var last_key_counts = 0

	func _init(_size:int) -> void:
		size = _size

	func push(key):
		current_key = key
		if last_key != current_key:
			keys.append(key)
			last_key_counts = 0
		if last_key == current_key:
			last_key_counts = last_key_counts + 1
			if last_key_counts < 2:
				keys.append(key)
#		print(current_key,"----", last_key,"count:",last_key_counts)
#		print(keys)

		last_key = current_key

	func get_keys():
		return keys

	func queue_size():
		return keys.size()

	func reset_queue():
		keys = []

var queue_timer = ATimer.new(self)
var q := Quene.new(QUEUE_SIZE)

func _ready() -> void:
	queue_timer.Interval = match_delay
	queue_timer.connect("timeout", self, "_match_keys")

func _start_match():
	if q.queue_size() <= min_keys_for_matching:
		return
	queue_timer.stop()
	queue_timer.start_timer()

func _input(event) -> void:
	if event as InputEventKey:
		var key = event.scancode
		if QUENED_KEYS.has(key) && event.pressed:
			q.push(key)
			_start_match()

func _match_keys():
	var keys = q.get_keys()
#	print("macth keys")
	q.reset_queue()
	queue_timer.stop()

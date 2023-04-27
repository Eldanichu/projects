extends Node2D

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
	KEY_0,
]

class Quene:

	var keys:Array = []
	var size:int = 32
	var current_key
	var last_key
	var last_key_counts = 0

	func _init(_size:int) -> void:
		size = _size
		pass

	func push(key):
		current_key = key
		if last_key != current_key:
			keys.append(key)
			last_key_counts = 0
		if last_key == current_key:
			last_key_counts = last_key_counts +1
		print(current_key,"----", last_key,"count:",last_key_counts)
		print(keys)

		last_key = current_key

	func get_keys():
		return keys

	func queue_size():
		return keys.size()

	func reset_queue():
		keys = []

	func lasts_are_dupe():
		pass

var queue_timer = ATimer.new(self)
var q := Quene.new(QUEUE_SIZE)

func _ready() -> void:
	queue_timer.Interval = 3
	queue_timer.connect("timeout", self, "_match_keys")
	pass

func _start_match():
	if q.queue_size() <= 5:
		return
	queue_timer.stop()
	queue_timer.start_timer()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key = event.scancode
		if QUENED_KEYS.has(key) && event.pressed:
			q.push(key)
			_start_match()

func _match_keys():
	var keys = q.get_keys()
	print("macth keys")
	q.reset_queue()
	q.reset_last()
	queue_timer.stop()

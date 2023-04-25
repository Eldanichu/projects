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
	var last_two:Array = []

	func _init(_size:int) -> void:
		size = _size
		pass

	func push(key):
		current_key = key
		last_two.append(key)
		if lasts_are_dupe():
			reset_last()
			reset_queue()
		if queue_size() >= size:
			reset_queue()
		keys.append(key)
		print(keys)

	func get_keys():
		return keys

	func queue_size():
		return keys.size()

	func reset_last():
		last_two = []

	func reset_queue():
		keys = []

	func lasts_are_dupe():
		var count = 0
		for i in range(last_two.size()):
			if last_two[i] == current_key && i<=1:
				count = count + 1
		return count >= 2

	func start_record():
		pass

	func stop_record():
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

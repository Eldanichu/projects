extends Node2D

const QUEUE_SIZE = 10
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
	var size:int = 10
	var current_key
	var last_two:Array = []

	func _init(_size:int) -> void:
		size = _size
		pass

	func push(key):
		current_key = key
		last_two.append(key)
		print(keys)
		if lasts_are_dupe() || queue_size() >= size:
			last_two = []
			reset_queue()
			return
		keys.append(key)

	func queue_size():
		return keys.size()

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

var queue_timer = Timer.new()
var q := Quene.new(QUEUE_SIZE)

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key = event.scancode
		if QUENED_KEYS.has(key) && event.pressed:
			q.push(key)
	pass

extends Node
class_name TimerPool

var pool:Array[OTimer] = []
var pool_map:Dictionary = {}

var _pool_size:int = 0
var timer_race:PackedByteArray = []

func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func push(timer_conifg:OTimerConfig) -> OTimer:
	var timer:OTimer = _create_timer(timer_conifg)
	pool.append(timer)
	pool_map[timer.name] = _pool_size
	timer_race.append(0)
	timer.timeout.connect(_on_timeout.bindv([_pool_size]))
	_update_pool_size()
	return timer

func pop():
	var popped = pool.pop_front() as OTimer
	if popped == null:
		return
	pool_map.erase(popped.name)
	_update_pool_size()

func remove_at(index:int):
	var popped = pool.pop_at(index) as OTimer
	if popped == null:
		return
	pool_map.erase(popped.name)
	remove_child(popped)
	popped.queue_free()
	_update_pool_size()

func remove(id:String):
	var _index = pool_map.get(id)
	if _index == null:
		return
	remove_at(_index)

func notify_all():
	for item in pool:
		item.restart()

func race() -> bool:
	var res = true
	for i in timer_race:
		if i == 0:
			res = false
			break
	return res

func all():
	for t in pool:
		t.start()

func _on_timeout(pos:int):
	timer_race[pos] = 1
	print("timers out", timer_race)

func _update_pool_size():
	_pool_size = len(pool)

func _create_timer(timer_config:OTimerConfig) -> OTimer:
	var name_t = "dt_{0}".format([_pool_size])
	var _timer:OTimer = OTimer.new()
	_timer.name = name_t
	_timer.interval = timer_config.interval
	_timer.max_tick = timer_config.max_tick
	add_child(_timer)
	var _node:OTimer = get_node_or_null(name_t) as OTimer
	return _node







extends Control
@onready var list: HFlowContainer = %list

@onready var pool:TimerPool = TimerPool.new()

var rnd = RandomEx.get_instance()

var bii_map:Dictionary = {}
var data:Array = []
func _ready() -> void:
	add_child(pool)
	for i in range(0,5):
		var ri = rnd.randomf(9.0)
		var config = OTimerConfig.new(ri)
		config.max_tick = 1
		var _timer = pool.push(config)
		_create_buff_indicator(_timer.name)
		_timer.on_update.connect(_on_timer_update.bindv([_timer.name]))
	pool.notify_all()

func _on_timer_update(dt,p,namet):
	bii_map[namet].value = p
	bii_map[namet].dt = dt
	var packs = []
	for key in bii_map:
		var item = bii_map[key]
		packs.append({"namet":key,"percent":item.value, "value":item.dt})

func _create_buff_indicator(nameb:String):
	var bi:PackedScene = ResourceLoader.load("res://Test/Buff.tscn") as PackedScene
	var bii:BuffIndicator = bi.instantiate() as BuffIndicator
	bii.name = nameb
	list.add_child(bii)
	var node = list.get_node_or_null(nameb) as BuffIndicator
	if node == null:
		return null
	bii_map[nameb] = node
	
	


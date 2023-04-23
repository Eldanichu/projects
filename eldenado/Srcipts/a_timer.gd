extends Timer
class_name ATimer

signal remains(reamins)

export var timer_id:String
export var Interval:float = 60

var _node:Node
var remains:float
var reduce_amount:float = 0

func _init(node:Node) -> void:
	self.timer_id = timer_id
	_node = node
	var isUnique = unique_timer();
	print(isUnique)
	if !isUnique:
		attach_to_node(node)


func _ready() -> void:
	setup()
	connect("timeout",self,"_timeout")
	pass

func _process(delta: float) -> void:
	if self.is_stopped():
		return
	emit_remains();

func setup()->void:
	self.wait_time = Interval
	reduce_amount = Interval
	self.autostart = false
	self.one_shot = false
	self.process_mode = 1

func emit_remains()-> void:
	remains = self.get_time_left();
	self.emit_signal('remains',remains);

func _timeout():
	emit_remains()

func start_timer() -> void:
		self.stop()
		setup()
		self.start(Interval)

func pause():
	self.stop()

func resume():
	if remains <= 0.0:
		start_timer()
	self.start(remains)

func reduce_amount(amount:float,type:String = "N")->void:
	if self.is_stopped():
		return

	var current_remains := remains

	if type == "%":
		reduce_amount = current_remains * (1 - (amount * 0.01))
	elif type == "N":
		reduce_amount = current_remains - amount

	if reduce_amount <= 0:
		reduce_amount = 1e-18
	emit_remains()
	wait_time = reduce_amount
	start()

func unique_timer() -> bool:
	var parent = get_parent()
	if !parent:
		parent = _node
	var children = parent.get_children()
	for node in children:
		if node as Timer and 'timer_id' in node:
			print('it has already set timer->'+node.timer_id)
			return true
	return false

func attach_to_node(node:Node) -> void:
	if node == null || 'add_child' in node:
		printerr('there is node to attach.')
	node.add_child(self);

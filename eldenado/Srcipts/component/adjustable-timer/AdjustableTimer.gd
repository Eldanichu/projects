extends Timer
class_name AdjustableTimer

signal remains(reamins)


export var timer_id:String
export var Interval:float = 60
export var RecduceAmount:float = 0
export var AutoStart:bool = false
export var once:bool = false

var _node
var remains:float
var reduce_amount:float
var timeout:bool = false

func _init(node:Node) -> void:
  self.timer_id = timer_id
  _node = node
  var isUnique = unique_timer();
  print(isUnique)
  if !isUnique:
    attach_to_node(node)


func _ready() -> void:
  setup()
  connect("timeout",self,"_on_timer_timeout")
  pass

func _process(delta: float) -> void:
  if timeout:
    return
  emit_remains();

func setup()->void:
  wait_time = Interval
  reduce_amount = Interval
  autostart = AutoStart
  one_shot = once

func emit_remains()-> void:
  remains = get_time_left();
  if timeout:
    remains = 0
    wait_time = 0
    stop()
  emit_signal('remains',remains);

func _on_timer_timeout():
  timeout = true
  emit_remains()

func start_timer() -> void:
  var stopped = is_stopped()
  if stopped:
    restart()

func restart() -> void:
  var stopped = is_stopped()
  if stopped:
    setup()
    reduce_amount = Interval
    timeout = false
    start(Interval)
    return
  stop()
  start(reduce_amount)

func reduce_amount(amount:float,type:String = "N")->void:
  if timeout:
    return
  var current_remains := remains
  if type == "%":
    reduce_amount = current_remains * (1 - (amount * 0.01))
  elif type == "N":
    reduce_amount = current_remains - amount
  if reduce_amount <= 0:
    reduce_amount = 0
    timeout = true
    emit_remains()
  print(reduce_amount)
  wait_time = reduce_amount
  restart()

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

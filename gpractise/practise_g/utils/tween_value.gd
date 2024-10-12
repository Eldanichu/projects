extends Resource
class_name TweenValue

var _node:Node
var _tween:Tween
var _tween_type := Tween.TRANS_QUAD
var _interval:float = 0.3
var _from = 0.0
var _to = 1.0

var _callback:Callable

func _init(node:Node,interval = 0.3):
	_node = node

func from(v) -> TweenValue:
	_from = v
	return self
	
func to(v) -> TweenValue:
	_to = v
	return self

func set_trans(trans_type) -> TweenValue:
	_tween_type = trans_type
	return self

func callback(cb:Callable) -> TweenValue:
	_callback = cb
	return self

func start():
	self.kill()
	_tween = _node.create_tween()
	self.set_tween()
	
func set_tween():
	_tween.bind_node(_node) \
	.set_parallel() \
	.set_trans(_tween_type) \
	.tween_method(value_changed, _from, _to , _interval)

func kill():
	if not _tween:
		return
	_tween.kill()
	
func value_changed(new_value):
	_to = new_value
	if not _callback:
		return
	_callback.bind(_to).call()

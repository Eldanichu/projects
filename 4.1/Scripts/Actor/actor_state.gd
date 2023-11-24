extends RefCounted
class_name ActorState

class CActorState:
	
	func _init():
		pass
	
	

var current_state:State

func _init():
	current_state = State.new()

func is_state(state:State):
	return state.value == current_state.value

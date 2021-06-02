extends Resource
class_name Xstate

"""
Todo List:
		-实现多个状态切换,并执行相应方法(Done)
"""
var states := {}
var state_name:String setget set_state,get_state
var state_action:String setget set_action,get_action
var lastState:String

func _change_state(newState:String, newAction:String) -> void:
		print("changeing state..")
		lastState = get_state()
		set_state(newState)
		set_action(newAction)
		states[get_state()] = get_action()

func _transition(inst, params:Dictionary):
		print("transitioning..")
		var action_func:String = states[get_state()]
		var action_func_name:String = "_use" + action_func
		if inst.has_method(action_func_name):
				inst.call(action_func_name, params)
		else:
				printerr("[ERROR]:Undefined action ->()", action_func_name)
				print_stack()


func dispatch(inst, state:String, action:String, params:Dictionary):
		var _action = _upperFirstLatter(action)
		_change_state(state, _action)
		_transition(inst, params)

func get_last_state() -> String:
		if lastState.empty():
				return ""
		return lastState

func set_state(state):
		state_name = state

func get_state() -> String:
		return state_name

func set_action(action):
		state_action = action

func get_action() -> String:
		return state_action

func _upperFirstLatter(s:String) -> String:
		var _st = s.substr(0,1)
		return s.replace(_st, _st.to_upper())

extends KinematicBody2D

const MAX_SPEED = 100
var velocity = Vector2.ZERO

func _ready() -> void:
  pass # Replace with function body.


func _physics_process(delta: float) -> void:
  move(delta)
  pass

func move(delta: float):
  var input_v = Vector2.ZERO
  input_v.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
  input_v.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
  input_v = input_v.normalized()

  if input_v != Vector2.ZERO:
    velocity = input_v
  else:
    velocity = Vector2.ZERO

  move_and_collide(velocity * delta * MAX_SPEED)

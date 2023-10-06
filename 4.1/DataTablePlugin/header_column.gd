extends Label

const MIN_SIZE = 16

@onready
var dragger:Button = %dragger

var button_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion:
		if button_down:
			var mouseX = get_local_mouse_position().x
			dragger.position.x = mouseX
			size.x = mouseX
			if size.x <= MIN_SIZE:
				size.x = MIN_SIZE
				dragger.position.x = MIN_SIZE
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_dragger_button_down():
	button_down = true
	pass # Replace with function body.


func _on_dragger_button_up():
	button_down = false
	pass # Replace with function body.

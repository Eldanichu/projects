extends Sprite
var _font = preload("res://Fonts/sim_sun.tres")

const SLOT_SIZE = Vector2(35.0,35.0)
const SLOT_OFFSET = Vector2(3,100)

onready var d = $".";
onready var slots = d.get_children();

var mp:Vector2;
var rect_v:Vector2;

func _ready():
	pass 

func _process(delta):
	mp = get_global_mouse_position();
	rect_v = mp - position
	update();

func _draw():
	_draw_debug_info()
	_draw_slots();

func _draw_slots():
	for i in range(0,slots.size()):
		draw_rect(
			Rect2(slots[i].position,SLOT_SIZE),
			Color(1,1,1,1),
			false
		)

func slot_range():
	pass

func _input(event):
	pass


func _draw_debug_info():
	draw_string(_font,Vector2(10,10),str(rect_v))









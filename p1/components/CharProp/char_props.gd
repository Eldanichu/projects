extends TextureRect
var _font = preload("res://Fonts/sim_sun.tres")

const SLOT_SIZE = Vector2(35.0,35.0)
const SLOT_OFFSET = Vector2(3,100)

onready var d = $".";
onready var slots = d.get_children();

var mp:Vector2;
var rect_v:Vector2;

var slot;

func _ready():
        var ast := AStar2D.new()
        ast.add_point(0,Vector2(100,200));


func _process(delta):
        mp = get_global_mouse_position();
        rect_v = mp - rect_global_position
        update();

func _draw():
        #_draw_debug_info()
        #_draw_slots();
        slot_range()
        draw_string(_font,Vector2(0,-90),str(slot))

func _draw_slots():
        for i in range(0,slots.size()):
                draw_rect(
                        Rect2(slots[i].position,SLOT_SIZE),
                        Color(1,1,1,1),
                        false
                )

func slot_range():
        slot= -1
        for i in range(0,slots.size()):
                if(
                        rect_v.x >= slots[i].position.x && 
                        rect_v.x <= (slots[i].position.x + SLOT_SIZE.x) &&
                        rect_v.y >= slots[i].position.y && 
                        rect_v.y <= (slots[i].position.y + SLOT_SIZE.y)
                ):
                        slot = str("true index:->",i)

func _input(event):
        pass


func _draw_debug_info():
        draw_string(_font,Vector2(10,10),str(slot))
        draw_string(_font,Vector2(10,26),str(slots[0].position.x))









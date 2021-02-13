extends TextureRect
class_name Inventory, "res://Images/ui/inv.png"

signal slot_dbclick(slot_index)

export var _font:Font = preload("res://Fonts/sim_sun.tres")


const ROW:int = 8
const COL:int = 5
const Y_OFFSET:float = 59.0
const X_OFFSET:float = 27.0

const EMPTY_SLOT:Object = null
const TOTAL_SLOTS:int = 50
const SLOT_WIDTH:float = 37.0
const SLOT_HEIGHT:float = 36.0
const SLOT_SIZE:Vector2 = Vector2(SLOT_WIDTH,SLOT_HEIGHT)

var mouse_pos:Vector2;
var current_item;
var rect_vector2:Vector2;
var rect_origin_vector2:Vector2;
var dragging:bool = false;
var hover:bool = false;

onready var slots:Array = []
onready var RECT_SIZE:Vector2 = get_rect().size;


func _ready():
    var item := ItemObject.new();
    item.set_type("RING")
    item.set_level(0);
    item.set_icon("i83")
    var g:= Gear.new();
    g.spwan_item(item)
    _init_inv_slots();
    _debugger()
    
func _process(_delta):
    mouse_pos = get_global_mouse_position();
    rect_vector2 = mouse_pos - Vector2(rect_global_position.x + X_OFFSET, rect_global_position.y + Y_OFFSET)
    rect_origin_vector2 = mouse_pos - Vector2(rect_global_position.x, rect_global_position.y)
    update()

func _draw():
    _draw_item();
    #_draw_slots();
    #_draw_moviable_area()
    #_draw_debug_info();
    #highlight_slot_index(Vector2(1,1) ,  Color.yellow)
    #_highlight_slot();
    """draw_rect(
                get_rect(),
                Color.white,
                false
            )"""

func _input(event):
    #drag_event(event)
    var _slot_index = _get_slot_index()
    if(_is_inside(_slot_index) && _slot_has_item(_slot_index)):
        hover = true
    if(event is InputEventMouseButton):
        if(event.button_index == BUTTON_LEFT):
            hover = false
            if(event.pressed):
                if(_is_inside(_slot_index)):
                    return
            if(event.doubleclick):
                emit_signal("slot_dbclick", _slot_index);


func drag_event(event) -> void:
    if event is InputEventMouseMotion:
        if(!_is_moviable_area()):
            dragging = false
    if(_is_moviable_area() && event is InputEventMouseButton):
        if not dragging and event.pressed:
            dragging = true
        if dragging and not event.pressed:
            dragging = false
    if event is InputEventMouseMotion and dragging:
        rect_global_position = event.position - rect_origin_vector2;



func set_slot_item(index:Vector2,item) -> void:
    if(!_is_inside(Vector2(index.x,index.y))): 
        print_debug("out of index of inventory.")
        return;
    slots[index.x][index.y] = item;

func get_slot_item(index:Vector2):
    if(!_is_inside(Vector2(index.x,index.y))): 
        print_debug("out of index of inventory.")
        return EMPTY_SLOT;
    return slots[index.x][index.y];

func highlight_slot_index(index: Vector2, color: Color) -> void:
    var slot_pos = _get_slot_position(index)
    if( _is_inside( index ) ):
        draw_rect(Rect2(slot_pos,SLOT_SIZE),color,false);

func _init_inv_slots() -> void:
    var _col = []
    for _col_ in range(0,COL):
        _col.append(EMPTY_SLOT)
    for _row_ in range(0,ROW):
        slots.append(_col.duplicate(true))

func _draw_item() -> void:
    for col_ in range(0,COL):
        for row_ in range(0,ROW):
            var _slot_index = Vector2(row_,col_)
            if(_slot_has_item(_slot_index)):
                var _pos = _get_slot_position(_slot_index)
                var _slot_item = get_slot_item(_slot_index);
                if(!_slot_item):
                    return
                var _item_size = _slot_item.icon.get_size()
                var _item_pos = Vector2(
                    _pos.x + (SLOT_SIZE.x *.5) - (_item_size.x *.5),
                    _pos.y + (SLOT_SIZE.y *.5) - (_item_size.y *.5)
                )
                draw_texture(_slot_item.icon , _item_pos)

func _draw_slots() -> void:
    for col_ in range(0,COL):
        for row_ in range(0,ROW):
            draw_rect(
                Rect2(
                    Vector2(
                    SLOT_WIDTH * row_ + X_OFFSET,
                    SLOT_HEIGHT * col_ + Y_OFFSET
                ),
                Vector2(SLOT_WIDTH,SLOT_HEIGHT)
            ),
                Color.white,
                false
            )

func _highlight_slot() -> void:
    highlight_slot_index(_get_slot_index() ,  Color.red)

func _get_slot_index() -> Vector2:
    return Vector2(
        floor((rect_vector2.x - 0.5) / SLOT_WIDTH),
        floor((rect_vector2.y - 0.5) / SLOT_HEIGHT)
    );

func _get_slot_position(slot_index_vector:Vector2) -> Vector2:
    return Vector2(
        SLOT_WIDTH * slot_index_vector.x + X_OFFSET , 
        SLOT_HEIGHT * slot_index_vector.y + Y_OFFSET
    )

func _draw_moviable_area() -> void:
    var _rect = Rect2(Vector2(0,0),Vector2(RECT_SIZE.x, Y_OFFSET - 3))
    draw_rect(_rect,Color(1,1,1,1),false)

func _slot_has_item(index:Vector2) -> bool:
    var _slot = get_slot_item(index);
    if(typeof(_slot) == TYPE_DICTIONARY):
        return true
    return false

func _is_inside(slot_index:Vector2) -> bool:
    return (
        slot_index.x >= 0 && 
        slot_index.y >= 0 && 
        slot_index.x < ROW && 
        slot_index.y < COL
    )

func _is_moviable_area() -> bool:
    return (
        rect_origin_vector2.x >= 0 && 
        rect_origin_vector2.y >= 0 && 
        rect_origin_vector2.x <= RECT_SIZE.x && 
        rect_origin_vector2.y <= Y_OFFSET - 3
    )

"""
Drawing Debug Infomations
"""
func _draw_debug_info():
    draw_string(_font,Vector2(0,-30),"global postion:{0}".format([mouse_pos]),Color.white)
    draw_string(_font,Vector2(0,-56),"rect postion:{0}".format([rect_vector2]),Color.white)
    draw_string(_font,Vector2(0,-116),"rect draggin:{0}".format([dragging]),Color.white)
    draw_string(_font,Vector2(0,-96),"rect_origin postion:{0}, inarea?->{1}".format([rect_origin_vector2,_is_moviable_area()]),Color.white)
    draw_string(_font,Vector2(0,-76),"rect index:{0}".format([_get_slot_index()]),Color.white)

func _debugger():
    var itemdata := ItemIcons.new()
    set_slot_item(Vector2(6,1), {"icon":itemdata.get_icon('i83')})
    set_slot_item(Vector2(2,1), {"icon":itemdata.get_icon('i83')})

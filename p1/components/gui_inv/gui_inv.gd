extends TextureRect

signal slot_dbclick(slot_index)


const ROW:int = 8
const COL:int = 5
const Y_OFFSET:float = 3.0
const X_OFFSET:float = 4.0

const EMPTY_SLOT:Object = null
const TOTAL_SLOTS:int = 50
const SLOT_WIDTH:float = 37.0
const SLOT_HEIGHT:float = 36.0
const SLOT_SIZE:Vector2 = Vector2(SLOT_WIDTH,SLOT_HEIGHT)

var mouse_pos:Vector2;
var rect_vector2:Vector2;
var rect_origin_vector2:Vector2;
var dragging:bool = false;
var hover:bool = false;

var hover_item = {
    "node":null,
    "obj":null
}

onready var slots:Array = [];
onready var RECT_SIZE:Vector2 = get_rect().size;


func _ready():
        _init_inv_slots();
        _debugger()

func _process(_delta):
        mouse_pos = get_global_mouse_position();
        rect_vector2 = mouse_pos - Vector2(rect_global_position.x + X_OFFSET, rect_global_position.y + Y_OFFSET);
        rect_origin_vector2 = mouse_pos - Vector2(rect_global_position.x, rect_global_position.y);
        update_hover_item_pos();
        update();

func _draw():
        _draw_item();
        _draw_debug_info()
        
func update_hover_item_pos():
    if(!hover_item.node):return;
    var _item = hover_item.node.get_child(0);
    _item.rect_position = mouse_pos;

func _input(event):
    if(event is InputEventMouseButton):
            if(event.button_index == BUTTON_LEFT):
                    on_slot_click(event);
                    on_slot_dblclick(event)
    on_slot_hover();

func on_slot_hover():
    hover = false;
    var _slot_index = _get_slot_index();
    if(_is_inside(_slot_index) && _slot_has_item(_slot_index)):
            hover = true;

func on_slot_click(event):
    if(event.pressed):
        var _slot_index = _get_slot_index();
        if(_is_inside(_slot_index)):
                _slot_click(_slot_index)

func on_slot_dblclick(event):
    if(event.doubleclick):
        var _slot_index = _get_slot_index();
        emit_signal("slot_dbclick", _slot_index);

func _slot_click(slot_index:Vector2):
    var _slot_item = get_slot_item(slot_index);
    if(_slot_has_item(slot_index)):
        if(hover_item.node):
            var temp_item = _slot_item;
            set_slot_item(slot_index, hover_item.obj)
            remove_hover_item(hover_item.node);
            hover_item.node = create_hover_item(temp_item)
            hover_item.obj = temp_item;
        else:
            hover_item.node = create_hover_item(_slot_item)
            hover_item.obj = _slot_item;
            set_slot_item(slot_index, EMPTY_SLOT)
    else:
        if(hover_item.node):
            set_slot_item(slot_index, hover_item.obj)
            remove_hover_item(hover_item.node);

func create_hover_item(item) -> Node:
    if(!item):
        print_debug("item Object is null");
        return null
    if(!item.icon):
        print_debug("item icon is null");
        return null

    var _parent_node := get_parent();
    var _item := Node.new();
    _item.name = item.name
    
    var _item_icon = TextureRect.new();
    _item_icon.texture = item.icon
    
    _item.add_child(_item_icon)
    _parent_node.add_child(_item)
    
    return _item
    
func remove_hover_item(item_obj):
    if(!item_obj):
        return;
    var _parent_node := get_parent();
    _parent_node.remove_child(item_obj)
    reset_hover_item();

func reset_hover_item():
    hover_item = {
        "node":null,
        "obj":null
    }

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
                print_debug("out of inventory range.")
                return;
        slots[index.x][index.y] = item;

func get_slot_item(index:Vector2)->Object:
        if(!_is_inside(Vector2(index.x,index.y))): 
                print_debug("out of inventory range.")
                return EMPTY_SLOT;
        return slots[index.x][index.y];

func _init_inv_slots() -> void:
        var _col = []
        for _col_ in range(0,COL):
                _col.append(EMPTY_SLOT)
        for _row_ in range(0,ROW):
                slots.append(_col.duplicate(true))

func _draw_item() -> void:
    var _slot_item;
    var _slot_index;
    for col_ in range(0,COL):
            for row_ in range(0,ROW):
                    _slot_index = Vector2(row_,col_)
                    if(_slot_has_item(_slot_index)):
                            _slot_item = get_slot_item(_slot_index);
                            if(!_slot_item):
                                return
                            var _pos = _get_slot_position(_slot_index)
                            var _item_size = _slot_item.icon.get_size()
                            var _item_pos = Vector2(
                                    _pos.x + (SLOT_SIZE.x *.5) - (_item_size.x *.5),
                                    _pos.y + (SLOT_SIZE.y *.5) - (_item_size.y *.5)
                            )
                            draw_texture(_slot_item.icon , _item_pos)

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
pass

func _debugger():
pass

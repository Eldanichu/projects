extends TextureRect

signal slot_dbclick(slot_index)


const ROW:int = 8
const COL:int = 5
const Y_OFFSET:float = 3.0
const X_OFFSET:float = 4.0

const EMPTY_SLOT:Object = null


var mouse_pos:Vector2;
var rect_vector2:Vector2;
var rect_origin_vector2:Vector2;


onready var slots:Array = [];
onready var RECT_SIZE:Vector2 = get_rect().size;


func _ready():
  _init_inv_slots();

func _process(_delta):
  mouse_pos = get_global_mouse_position();
  rect_vector2 = mouse_pos - Vector2(rect_global_position.x + X_OFFSET, rect_global_position.y + Y_OFFSET);
  rect_origin_vector2 = mouse_pos - Vector2(rect_global_position.x, rect_global_position.y);
  update();


func _init_inv_slots() -> void:
  var _cols = []
  for c in range(0,COL):
    _cols.append(0)
  for r in range(0,ROW):
    slots.append(_cols.duplicate(true))
  print(slots)
  _render_slots()

func _render_slots():
  for col_ in range(0,COL):
    for row_ in range(0,ROW):
      var _slot = Slot.new()
      _slot.position = Vector2(row_,col_);
      self.add_child(_slot)

func _on_slot_click(p):
  print(p)

func _is_inside(slot_index:Vector2) -> bool:
  return (
    slot_index.x >= 0 &&
    slot_index.y >= 0 &&
    slot_index.x < ROW &&
    slot_index.y < COL
  )

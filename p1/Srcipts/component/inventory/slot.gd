extends TextureRect
class_name Slot

export var position:Vector2 = Vector2(0,0)
export var offset:Vector2 = Vector2(0,0)

const EMPTY_SLOT:Object = null
const WIDTH:float = 37.0
const HEIGHT:float = 38.0
const SIZE:Vector2 = Vector2(WIDTH,HEIGHT)

var _item:SlotItem = null setget set_item,get_item;

var event_position:Vector2;

func _input(event):
  if(event is InputEventMouseButton):
    if(event.button_index == BUTTON_LEFT):
      on_slot_click(event)


func on_slot_click(event):
  if(event.pressed):
    event_position = event.position
    print(_get_slot_index())

func _process(delta: float) -> void:
  update();

func _draw() -> void:
  render()

func render() -> void:
  var _pos = _get_slot_position(position)
  draw_rect(Rect2(_pos,SIZE),Color.white,false)

func _get_slot_position(index:Vector2) -> Vector2:
  return Vector2(
    WIDTH * index.x + offset.x ,
    HEIGHT * index.y + offset.y
  )

func _get_slot_index():
  var _index = (event_position / SIZE) - (Vector2(1,2) - Vector2(0.5,0.5))
  return Vector2(floor(_index.x),floor(_index.y))

func _inside_of_slot(postion):
  return true

func set_item(item:SlotItem) -> void:
  _item = item

func get_item() -> SlotItem:
  return _item

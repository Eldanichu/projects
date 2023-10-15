extends MenuButton
class_name MenuButtonEx

signal equipment_action(id)

## ---------------------CONSTANTS START---------------------
const popup_item_name_map:Array = [
	"Sell",
	"Forge Item",
	"Use Item",
	"Equip On",
	"Break Item",
]
## ---------------------CONSTANTS END---------------------

## ---------------------ENUM START---------------------
enum COMPONENT {
	EQUIPMENT,
	EQUIPED,
	ITEM,
}

enum PROP {
	SELLABLE ,
	FOREGIABLE,
	USEABLE ,
	EQUIPABLE ,
	BREAKABLE
}
## ---------------------ENUM END---------------------

## ---------------------EXPORTS START---------------------
@export_enum(
	"EQUIPMENT",
	"EQUIPED",
	"ITEM"
)
var component:int = COMPONENT.EQUIPMENT

@export_flags(
	"SELLABLE",
	"FOREGIABLE",
	"USEABLE",
	"EQUIPABLE",
	"BREAKABLE"
)
var props = 0
## ---------------------EXPORTS END---------------------

var is_hover = 0
var popup_show = 0
var selections:Array = []
var mouse_position:Vector2 = Vector2.ZERO
var window_size:Vector2 = Vector2.ZERO
var tip_offset:int = 12

@onready
var tip := %tip

func _ready():
	window_size = DisplayServer.window_get_size()
	mouse_entered.connect(_mouse_hover_event.bind(1))
	mouse_exited.connect(_mouse_hover_event.bind(0))
	set_selected_enums([PROP.BREAKABLE, PROP.EQUIPABLE])
	reload()

func _gui_input(_event):
	if popup_show:
		tip.visible = false
		return
	mouse_position = get_global_mouse_position()
	tip.position = mouse_position + Vector2(tip_offset, tip_offset)
	confine_tip()

func confine_tip():
	var tip_size:Vector2 = tip.size
	var offset:Vector2
	var origin_position = mouse_position.x + (tip_size.x + tip.position.x)
	
	if  origin_position >= window_size.x - tip_size.x:
		offset = mouse_position - Vector2(tip_size.x + tip_offset, 0)
		tip.position = Vector2(0, offset.y + tip_offset)

func _mouse_hover_event(state:int):
	is_hover = state
	tip.visible = bool(is_hover)
		
func load_popup_items():
	var pop_items = get_popup()
	pop_items.clear()
	if component == COMPONENT.EQUIPED:
		pop_items.add_item("Equip Out", 33)
	for i in selections:
		pop_items.add_item(popup_item_name_map[i],i);
	pop_items.id_pressed.connect(_on_popup_item_pressed.bind())

func reload():
	selections = get_selected_enums(PROP,props)
	load_popup_items()

func _on_popup_item_pressed(id):
	log.d(id)
	emit_signal("equipment_action",id)

func get_selected_enums(enum_var:Dictionary, flag_var:int):
	var _enum = enum_var
	var count = -1
	var arr = []
	for item in _enum:
		count = count + 1
		var bit:int = int(pow(2,_enum[item]))
		if flag_var & bit:
			arr.append(count)
	return arr

func set_selected_enums(enum_vars:Array):
	var bit = 0
	for index in range(0,len(enum_vars)):
		bit += int(pow(2,enum_vars[index]))
	props = bit

func _on_toggled(button_pressed):
	popup_show = button_pressed
	tip.visible = false

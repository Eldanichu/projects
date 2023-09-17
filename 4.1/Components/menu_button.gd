extends MenuButton
class_name MenuButtonEx

enum COMPONENT {
	EQUIPMENT,
	EQUIPED,
	ITEM,
}

@export_enum("EQUIPMENT","EQUIPED","ITEM")
var component:int = COMPONENT.EQUIPMENT

enum PROP {
	SELLABLE ,
	FOREGIABLE,
	USEABLE ,
	EQUIPABLE ,
	BREAKABLE
}
@export_flags(
	"SELLABLE",
	"FOREGIABLE",
	"USEABLE",
	"EQUIPABLE",
	"BREAKABLE"
)
var props = 0

const popup_item_name_map:Array = [
	"Sell",
	"Forge Item",
	"Use Item",
	"Equip On",
	"Break Item",
]

var selections:Array = []

func _ready():
#	print(props)
	set_selected_enums([PROP.BREAKABLE, PROP.EQUIPABLE])
	reload()

func _process(delta):
	pass

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
	pass


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

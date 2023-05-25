extends PanelContainer

onready var skill_name := $"%skill_name"
onready var slot := $"%slot"

var id:String
var icon:Texture

func _ready() -> void:
	slot.set_item({
		"id":"0001",
		"icon":"00004",
		"type":Globals.SLOT_TYPE.SKILL_ITEM,
		"disabled":false
	})
	slot.connect("pick",self,"_on_pick")

func _on_pick(item:Dictionary):
	print("[skill line pick item ]",item)
	var mouse_item:MouseFloatItem = GameUtils.get_mouse_item(self)
	var mouse_item_obj = mouse_item.item
	if mouse_item_obj.id == item.id && mouse_item_obj.from == item.from:
		mouse_item.clear()
		return
	mouse_item.item = item.duplicate(true)


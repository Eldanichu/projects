extends PanelContainer

onready var skill_name := $"%skill_name"
onready var slot := $"%slot"

var id:String
var icon:Texture

func _ready() -> void:
	var SLOT_TYPE = slot.SLOT_TYPE.SKILL_ITEM
	slot.set_item({
		"id":"0001",
		"appr":"00004",
		"type":SLOT_TYPE,
		"disabled":false
	})
	slot.connect("pick",self,"_on_pick")

func _on_pick(item:Dictionary):
	print(item)
	var mouse_item = GameUtils.get_root_node(self,"mouse_item")
	mouse_item.item = item.duplicate(true)
	pass

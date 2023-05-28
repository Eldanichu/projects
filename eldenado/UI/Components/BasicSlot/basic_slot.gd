extends Control
class_name BasicSlot

const SLOT_TYPE = Globals.SLOT_TYPE
const SLOT_ITEM_NODE_NAME = "slot_item"

const EVENT:Dictionary = {
	"USE_SKILL":"use_skill",
	"USE_ITEM":"use_item",
}

export(SLOT_TYPE) var type:int

onready var key = $"%key"
onready var slot_item:Item = $"%slot_item"


var slot:SlotObject = SlotObject.new()

func _ready() -> void:
	setup()

func _process(delta):
	show_key()
	pass

func setup():
	bind_events()

func bind_events():
	
	pass

func show_key():
	var color = Color.white
	color.a = 0.6
	if slot.type == SLOT_TYPE.SKILL && slot.source != Globals.ITEM_SOURCE.INVENTORY && slot.key:
		key.set("align", HALIGN_RIGHT)
		key.set("valign", VALIGN_BOTTOM)
		key.visible = true
	else:
		key.set("align", HALIGN_CENTER)
		key.set("valign", VALIGN_CENTER)
		key.visible = false
	key.set("custom_colors/font_color", color)

	var _text = str(slot.key)
	if StringUtil.isEmptyOrNull(_text):
		key.text = ""
	else:
		key.text = _text

func get_instance() -> Item:
	return slot_item

func is_empty():
	var item = get_item()
	if item:
		return false
	return true

func get_item() -> ItemObject:
	var item = slot_item.item
	return item

func add_item(item:ItemObject):
	if get_item():
		return
	slot_item.set_item(item)

func remove_item():
	var item = get_item()
	if item:
		item.remove()


func get_skill() -> SkillObject:
	var skill = slot_item.skill
	return skill

func add_skill(skill:SkillObject):
	if get_skill():
		return
	slot_item.set_skill(skill)
	
	
"""
Events
"""


extends Label
class_name ItemObject

var ItemInfo:Dictionary = {
	idx = '',
	name = '',
	type = '',
	price = 0
} setget set_item_info,get_item_info;


func _ready():
	self.text = ItemInfo.name;
	self.align = Label.ALIGN_CENTER;
	self.valign = Label.ALIGN_CENTER;
	self.clip_text = true;

func set_item_info(data:Dictionary) -> void:
	ItemInfo = data;

func get_item_info() -> Dictionary:
	return ItemInfo;

func _exit_tree():
	queue_free();

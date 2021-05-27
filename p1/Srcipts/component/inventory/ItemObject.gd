extends Label
class_name ItemObject

var ItemInfo:Dictionary = {
	idx = '',
	name = '',
	type = '',
	price = 0
};


func _ready():
	self.text = ItemInfo.name;
	self.align = Label.ALIGN_CENTER;
	self.valign = Label.ALIGN_CENTER;
	self.clip_text = true;

func _exit_tree():
	queue_free();

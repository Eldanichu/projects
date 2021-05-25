extends Label
class_name SlotItem


func _init(text:String = '1'):
	self.text = text;
	self.align = Label.ALIGN_CENTER;
	self.valign = Label.ALIGN_CENTER;
	self.clip_text = true;
	pass


func _exit_tree():
	queue_free();

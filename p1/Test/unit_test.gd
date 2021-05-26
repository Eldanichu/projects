extends Control
onready var infobox:RichTextLabel = $col_1/row_2/info_box;

func _on_class_pressed() -> void:
		var sc = CustomClass.new();
		sc._a = 'ddd'
		callParam(sc)


func callParam(b:CustomClass):
		pprint([b.a,b._a])


func pprint(infos:Array=[]):
	infobox.get_v_scroll()
	for info in infos:
		infobox.append_bbcode(str(info,'\n'))


func _on_class_2_pressed():
	infobox.clear();



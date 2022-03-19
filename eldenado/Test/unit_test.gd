extends Control
onready var infobox:RichTextLabel = $col_1/row_2/info_box;

var timer_count:int = 0
var timer:CoolDown
func _on_class_pressed() -> void:
    var sc = CustomClass.new();
    sc._a = 'ddd'
    callParam(sc)
    timer = CoolDown.new("s1",10)
    add_child(timer)
    timer.connect("cooldown",self,"_on_cooldown")
    timer.connect("done",self,"_on_timer_done")

func callParam(b:CustomClass):
    pprint([b.a,b._a])


func pprint(infos:Array=[]):
  infobox.get_v_scroll()
  for info in infos:
    infobox.append_bbcode(str(info,'\n'))


func _on_class_2_pressed():
  infobox.clear();

func _on_cooldown(value):
  infobox.append_bbcode(str(value,'\n'))
  pass

func _on_timer_done(ready):
  infobox.append_bbcode("done")


func _on_class_3_pressed() -> void:
  timer.set_reduce_amount(1)

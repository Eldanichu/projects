extends Control
onready var infobox:RichTextLabel = $col_1/row_2/info_box;
onready var row:HBoxContainer = $col_1/row_2;

var timer_count:int = 0
var timer:CoolDown

onready var stats = $m/vbox/top/stats
var rnd = RandomNumberGenerator.new()

func _on_hp_desc_pressed() -> void:
  rnd.randomize()
  stats.hp = stats.hp - rnd.randi_range(1,5)
  pass


func _on_hp_restore_pressed() -> void:
  stats.hp = stats.hp_max
  pass


func _on_exp_inc_pressed() -> void:
  rnd.randomize()
  stats.iExp = stats.iExp + rnd.randi_range(10,1500)
  pass

func _ready() -> void:
  Logger.debug('test ready')


func _on_class_pressed() -> void:
  find_node('label').value_b = 100.0
  pass
#  var sc = CustomClass.new();
#  sc._a = 'ddd'
#  callParam(sc)
#  timer = CoolDown.new("s1",1)
#  add_child(timer)
#  timer.connect("cooldown",self,"_on_cooldown")
#  timer.connect("done",self,"_on_timer_done")

func callParam(b:CustomClass):
  pprint([b.a,b._a])


func pprint(infos:Array = []):
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
  if(ObjectUtil.is_null(timer)):
    return
  timer.set_reduce_amount(1)

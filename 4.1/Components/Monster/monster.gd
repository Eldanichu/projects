extends GameObject
class_name MonsterScene

@onready var m_name = %m_name
@onready var m_hp = %m_hp
@onready var m_lv = %m_lv

@onready var t_attack:TweenProgress = $t_attack

var attacker:GameObject = null
var mon_stat:MonStat

var mon_obj:MonObject:
	set(mon):
		mon_obj = mon
		mon_stat = mon_obj.mon_stat
		mon_stat.add_event(
			update,"mon_".format([RandomEx.get_instance().uid()])
			)

func _ready():
	setup()
	pass 

func _process(delta):
	pass
	

func setup():
	mon_stat.trigger_event()
#	t_attack.set_interval(2).start()

func update(changes):
	if not is_inside_tree():
		return
	m_hp.text = "{0}/{1}".format([mon_stat.HP,mon_stat.HPMAX])
	m_lv.text = "Lv:{0}".format([str(mon_stat.LEVEL)])
	m_name.text = mon_stat.DNAME


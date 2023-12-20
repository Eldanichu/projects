extends GameObject
class_name MonsterScene

signal spawned(mon_inst)
signal attack(mon_inst,dmg)
signal dead(mon_inst)

@onready var m_name = %m_name
@onready var m_hp = %m_hp
@onready var m_lv = %m_lv

@onready var t_attack:TweenProgress = $t_attack

var r := RandomEx.get_instance()
var mon_obj:MonObject
var mon_stat:MonStat

func _ready():
	setup()

func setup():
	if not mon_obj:
		return
	name = G.get_instance_mon_name()
	mon_stat = mon_obj.stats
	S.stats_changed.connect(_on_stats_update)
	S.stats_changed.emit()
	set_auto_attack_timer()
	emit_signal("spawned", self)

func set_auto_attack_timer():
	var atk_interval_sec = mon_stat.ATKSPD / 1000.0
	var rnd = r.randomf(0.5)
	t_attack.set_interval(atk_interval_sec + rnd)

func auto_attack():
	t_attack.start()

func kill():
	if mon_obj.dead():
		return
	mon_obj.kill()
	t_attack.kill()
	emit_signal("dead",self)

func is_dead():
	return mon_obj.dead()

func _on_stats_update():
	if not is_inside_tree():
		return
	m_hp.text = "{0}/{1}".format([mon_stat.HP,mon_stat.HPMAX])
	m_lv.text = "Lv:{0}".format([str(mon_stat.LEVEL)])
	m_name.text = mon_stat.DNAME

func _on_t_attack_timeout():
	if mon_obj.dead():
		t_attack.stop()
		return
	var dmg = r.randomi(1)
	emit_signal("attack", self, dmg)


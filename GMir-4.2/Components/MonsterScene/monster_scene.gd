extends GameObject
class_name MonsterScene

@onready var m_name = %m_name
@onready var m_hp = %m_hp
@onready var m_lv = %m_lv

@onready var attack_timer:TweenProgress = $t_attack

var r := RandomEx.get_instance()
var mon_obj:MonObject
var mon_stat:MonStat

func _ready():
	mon_obj.stats_change.connect(_on_stats_update)
	mon_obj.on_dead.connect(_on_dead)
	setup()

func setup():
	if not mon_obj:
		return
	name = G.get_instance_mon_name()
	attack_timer.timeout.connect(_on_attack)
	mon_stat = mon_obj.stats
	mon_obj.stats_change.emit()
	set_auto_attack_timer()
	mon_obj.spawned.emit()

func set_auto_attack_timer():
	var atk_interval_sec = mon_stat.ATKSPD / 1000
	attack_timer.set_interval(atk_interval_sec)

func auto_attack():
	attack_timer.start()

func _on_attack():
	mon_obj.on_attack.emit()

func _on_dead():
	attack_timer.stop()

func _on_stats_update():
	m_hp.text = "{0}/{1}".format([mon_stat.HP,mon_stat.HPMAX])
	m_lv.text = "Lv:{0}".format([str(mon_stat.LEVEL)])
	m_name.text = mon_stat.DNAME


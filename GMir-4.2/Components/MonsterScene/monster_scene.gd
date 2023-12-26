extends GameObject
class_name MonsterScene

@onready var m_name = %m_name
@onready var m_hp = %m_hp
@onready var m_lv = %m_lv

@onready var t_attack:TweenProgress = $t_attack

var r := RandomEx.get_instance()
var mon_obj:MonObject
var mon_stat:MonStat

func _enter_tree():
	mon_obj.stats_change.connect(_on_stats_update)

func _ready():
	setup()

func setup():
	if not mon_obj:
		return
	name = G.get_instance_mon_name()
	t_attack.timeout.connect(_on_attack)
	mon_stat = mon_obj.stats
	set_auto_attack_timer()
	mon_obj.spawned.emit(self)

func set_auto_attack_timer():
	var atk_interval_sec = mon_stat.ATKSPD / 1000.0
	var rnd = r.randomf(0.5)
	t_attack.set_interval(atk_interval_sec + rnd)

func auto_attack():
	t_attack.start()

func _on_attack():
	if is_dead():
		mon_obj.on_dead.emit(self)
		return
	mon_obj.on_attack.emit(self)

func is_dead() -> bool:
	if not mon_obj.dead():
		return false
	t_attack.kill()
	return true

func _on_stats_update():
	m_hp.text = "{0}/{1}".format([mon_stat.HP,mon_stat.HPMAX])
	m_lv.text = "Lv:{0}".format([str(mon_stat.LEVEL)])
	m_name.text = mon_stat.DNAME
	

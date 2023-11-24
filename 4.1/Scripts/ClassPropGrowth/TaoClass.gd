extends BaseActorClass
class_name TaoClass

var primary:PrimaryStat
var slave:SecondaryStat

var _stat

func _init(stat):
	super()
	_stat = stat
	get_stats()
	hp_base = 16
	hp_acc = 2.5
	hp_ratio = 14
	hp_rate = 1
	
	mp_base = 5
	mp_acc = 6.6
	mp_ratio = 1.1
	mp_rate = 1
	
	atk_acc = 2.3
	atk_base = 1
	atk_rate = 1
	atk_ratio = 1.5

func get_stats():
	if _stat as PrimaryStat:
		primary = _stat
	elif _stat as SecondaryStat:
		slave = _stat

func update():
	var level = primary.LEVEL
	primary.HPMAX = int(hp_ratio + (level / (1 + hp_base) + hp_acc) * level)
	primary.MPMAX = int(mp_ratio + (level / (1 + mp_base) + mp_acc) * mp_rate * level)







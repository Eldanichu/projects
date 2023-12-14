extends BaseActorClass
class_name TaoClass

func _init():
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

func update():
	var level = stats0.LEVEL
	stats0.HPMAX = int(hp_ratio + (level / (1 + hp_base) + hp_acc) * level)
	stats0.MPMAX = int(mp_ratio + (level / (1 + mp_base) + mp_acc) * mp_rate * level)




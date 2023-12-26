extends ActorClass
class_name TaoClass
func is_class_name(name_of_class:String) -> bool:
	_class_name = "TaoClass"
	return name_of_class == _class_name

func _init(actor_player:ActorPlayer):
	hp_base = 16
	hp_acc = 25
	hp_ratio = 14
	hp_rate = 1
	
	mp_base = 5
	mp_acc = 33
	mp_ratio = 11
	mp_rate = 1
	
	atk_acc = 7
	atk_base = 1
	atk_rate = 1
	atk_ratio = 2
	super(actor_player)

func update_props():
	var level = stats.LEVEL
	var max_hp = int(hp_ratio + (level / (1 + hp_base) + hp_acc) * level)
	var max_mp = int(mp_ratio + (level / (1 + mp_base) + mp_acc) * mp_rate * level)
	var max_exp = int(level * 30 + level)
	stats.HP = max_hp
	stats.MP = max_mp
	_actor_player.set_hp(stats.HP, max_hp)
	_actor_player.set_mp(stats.MP, max_mp)
	_actor_player.set_exp(max_exp)
	_actor_player.set_atk(max(ceil(level * (atk_acc + atk_ratio)), 1))
	_actor_player.set_def(ceil(level * 1))




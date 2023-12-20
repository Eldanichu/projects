extends ActorClass
class_name TaoClass
func is_class_name(name_of_class:String) -> bool:
	_class_name = "TaoClass"
	return name_of_class == _class_name


func _init(actor_player:ActorPlayer):
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
	super(actor_player)






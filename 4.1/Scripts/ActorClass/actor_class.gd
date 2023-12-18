extends RefCounted
class_name ActorClass
var _class_name = "ActorClass"
func is_class_name(name_of_class:String) -> bool:
	return name_of_class == _class_name

var hp_ratio
var hp_base
var hp_acc
var hp_rate

var mp_ratio
var mp_base
var mp_acc
var mp_rate

var def_ratio
var def_base
var def_acc = 0.325
var def_rate = 0.117

var atk_ratio
var atk_base
var atk_acc
var atk_rate

var exp_ratio = 2
var exp_base = 20
var exp_acc = 14
var exp_rate = 1.1

var _actor_player:ActorPlayer
var stats:BaseStat
func _init(actor_player:ActorPlayer):
	_actor_player = actor_player
	stats = actor_player.stats

func calculate(const_number:float, rate:float, acc:float, level:int, is_p1:bool):
	var _lv = level;
	if const_number != 0:
		_lv *= const_number
	var value = floor(_lv * rate + acc * rate + 1);
	if is_p1:
		value += _lv * acc;

	return int(floor(value));

func update_props():
	var level = stats.LEVEL
	var max_hp = int(hp_ratio + (level / (1 + hp_base) + hp_acc) * level)
	var max_mp = int(mp_ratio + (level / (1 + mp_base) + mp_acc) * mp_rate * level)
	_actor_player.set_hp(stats.HP, max_hp)
	_actor_player.set_mp(stats.MP, max_mp)



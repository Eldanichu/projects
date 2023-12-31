extends Resource
class_name GameActor

var stats:BaseStat

func _init(p_stat:BaseStat):
	stats = p_stat

func set_hp_t(value:int):
	stats.HP += value
	if stats.HP >= stats.HPMAX:
		stats.HP = stats.HPMAX
	if value < 0:
		dead()

func set_hp(value:int, max_value:int = -1):
	if max_value  == -1:
		max_value = stats["HPMAX"]
	stats["HP"] = value
	stats["HPMAX"] = max_value

func get_hp(stringify:bool, is_max:bool = false):
	var _min = stats["HP"]
	var _max = stats["HPMAX"]
	if stringify:
		return "{0}/{1}".format([_min,_max])
	if is_max:
		return _max
	return _min

func set_mp(value:int, max_value:int = -1):
	if max_value  == -1:
		max_value = stats["MPMAX"]
	stats["MP"] = value
	stats["MPMAX"] = max_value

func get_mp(stringify:bool, is_max:bool = false):
	var _min = stats["MP"]
	var _max = stats["MPMAX"]
	if stringify:
		return "{0}/{1}".format([_min,_max])
	if is_max:
		return _max

	return _min

func set_exp(value):
	stats.EXPMAX = value

func set_exp_t(value:int):
	var amount = value
	var _max_exp = stats["EXPMAX"]
	if amount < _max_exp:
		stats["EXP"] += amount
		level_up()

	while _max_exp <= amount:
		stats["EXP"] += amount
		amount = amount - _max_exp
		stats["EXP"] = amount
		level_up()

func level_up(direct:bool = false):
	if stats["EXP"] <= stats["EXPMAX"] and not direct:
		return
	stats["LEVEL"] += 1

func revive():
	set_hp_t(stats.HPMAX)

func is_dead():
	if stats.HP <= 0:
		stats.HP = 0
		return true
	return false

func dead():
	pass

func kill():
	stats.HP = 0


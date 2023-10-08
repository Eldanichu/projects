extends Resource
class_name GameActor

const epp := Enums.PLAYER_PRIMARY_STATS
const epe := Enums.PLAYER_EXCLUSIVE_STATS

const s_ratio:Dictionary = {
	"exp":1.05
}

var stats:Dictionary = {
	epe.ATTACK : 100,
	
	epe.ATTACK_SPEED : 0,
	epe.CAST_SPEED : 30,
	
	epe.DFIRE : 0,
	epe.DICE : 0,
	epe.DWIND : 0,
	epe.DWATER : 0,
	
	epe.RATTACK : 0,
	epe.RFIRE : 0,
	epe.RICE : 0,
	epe.RWIND : 0,
	epe.RWATER : 0,
	
	epe.CRITICAL_CHANCE : 40,
	epe.CRITICAL_DAMAGE : 0,
}

var ms:Dictionary = {
	epp.HP:10,
	epp.HPMAX:100,
	epp.MP:5,
	epp.MPMAX:15,
	epp.EXP:1,
	epp.EXPMAX:100,
}

func _init():
	
	pass

func get_hp(strgify:bool, is_max:bool = false):
	var _min = ms[epp.HP]
	var _max = ms[epp.HPMAX]
	if strgify:
		return "{0}/{1}".format([_min,_max])
	if is_max:
		return _max
	return _min

func get_mp(strgify:bool, is_max:bool = false):
	var _min = ms[epp.MP]
	var _max = ms[epp.MPMAX]
	if strgify:
		return "{0}/{1}".format([_min,_max])
	if is_max:
		return _max

	return _min

func set_hp(value:int, max_value:int = -1):
	if max_value  == -1:
		max_value = ms[epp.HPMAX]
	ms[epp.HP] = value
	ms[epp.HPMAX] = max_value
	emit_stats_change()

func set_mp(value:int, max_value:int = -1):
	if max_value  == -1:
		max_value = ms[epp.MPMAX]
	ms[epp.MP] = value
	ms[epp.MPMAX] = max_value
	emit_stats_change()

func give_hp(value:int):
	ms[epp.HP] = min(ms[epp.HP] + value, ms[epp.HPMAX])
	emit_stats_change()
	pass

func damage(value:int):
	ms[epp.HP] = max(ms[epp.HP] - value, 0)
	emit_stats_change()
	pass

func give_exp(value:int):
	var amount = value
	var _max_exp = ms[epp.EXPMAX]
	while _max_exp <= amount:
		ms[epp.EXP] += amount
		amount = amount - _max_exp
		if is_level_up():
			level_up()

func is_level_up():
	return ms[epp.EXP] >= ms[epp.EXPMAX]

func level_up():
	var _ratio = s_ratio.exp
	_ratio += s_ratio.exp
	ms[epp.EXPMAX] += 100 * _ratio
	ms[epp.EXP] = 0

func emit_stats_change():
	PlayerEvent.emit_signal("stats_change")

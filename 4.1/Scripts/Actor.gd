extends Resource
class_name GameActor

const e_main_stats:Enums.PLAYER_PRIMARY_STATS = Enums.PLAYER_PRIMARY_STATS
const e_stats:Enums.PLAYER_EXCLUSIVE_STATS = Enums.PLAYER_EXCLUSIVE_STATS


var stats:Dictionary = {
	e_stats.ATTACK : 100,
	
	e_stats.ATTACK_SPEED : 0,
	e_stats.CAST_SPEED : 30,
	
	e_stats.DFIRE : 0,
	e_stats.DICE : 0,
	e_stats.DWIND : 0,
	e_stats.DWATER : 0,
	
	e_stats.LINE_SPLIT:null,
	
	e_stats.RATTACK : 0,
	e_stats.RFIRE : 0,
	e_stats.RICE : 0,
	e_stats.RWIND : 0,
	e_stats.RWATER : 0,
	
	e_stats.CRITICAL_CHANCE : 40,
	e_stats.CRITICAL_DAMAGE : 0,
}

var main_stats:Dictionary = {
	e_main_stats.HP:100,
	e_main_stats.HPMAX:100,
	e_main_stats.MP:15,
	e_main_stats.MPMAX:15,
	e_main_stats.EXP:1,
	e_main_stats.EXPMAX:100,
}

func set_hp(value:int, max_value:int = -1):
	if max_value  == -1:
		max_value = main_stats[e_main_stats.HPMAX]
	main_stats[e_main_stats.HP] = value
	main_stats[e_main_stats.HPMAX] = max_value

func set_mp(value:int, max_value:int = -1):
	if max_value  == -1:
		max_value = main_stats[e_main_stats.MPMAX]
	main_stats[e_main_stats.MP] = value
	main_stats[e_main_stats.MPMAX] = max_value

func give_hp(value:int):
	var amount:int = value
	
	pass

func give_damage(value:int):
	pass


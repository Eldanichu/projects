extends Resource
class_name GameActor

const enum_stats:Enums.PLAYER_EXCLUSIVE_STATS = Enums.PLAYER_EXCLUSIVE_STATS

const stats:Dictionary = {
	enum_stats.ATTACK : 100,
	
	enum_stats.ATTACK_SPEED : 0,
	enum_stats.CAST_SPEED : 30,
	
	enum_stats.DFIRE : 0,
	enum_stats.DICE : 0,
	enum_stats.DWIND : 0,
	enum_stats.DWATER : 0,
	
	enum_stats.LINE_SPLIT:null,
	
	enum_stats.RATTACK : 0,
	enum_stats.RFIRE : 0,
	enum_stats.RICE : 0,
	enum_stats.RWIND : 0,
	enum_stats.RWATER : 0,
	
	enum_stats.CRITICAL_CHANCE : 40,
	enum_stats.CRITICAL_DAMAGE : 0,
}



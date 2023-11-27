extends Resource
class_name GameActor

var secondary_stats:SecondaryStat
var primary_stats:PrimaryStat
var actor_state:ActorState

func _init():
	actor_state = ActorState.new()
	
	primary_stats = PrimaryStat.new()
	var tao = TaoClass.new(primary_stats)
	primary_stats.set_class(tao)
	
	secondary_stats = SecondaryStat.new()


func set_hp(value:int, max_value:int = -1):
	if max_value  == -1:
		max_value = primary_stats["HPMAX"]
	primary_stats["HP"] = value
	primary_stats["HPMAX"] = max_value

func get_hp(stringify:bool, is_max:bool = false):
	var _min = primary_stats["HP"]
	var _max = primary_stats["HPMAX"]
	if stringify:
		return "{0}/{1}".format([_min,_max])
	if is_max:
		return _max
	return _min

func set_mp(value:int, max_value:int = -1):
	if max_value  == -1:
		max_value = primary_stats["MPMAX"]
	primary_stats["MP"] = value
	primary_stats["MPMAX"] = max_value

func get_mp(stringify:bool, is_max:bool = false):
	var _min = primary_stats["MP"]
	var _max = primary_stats["MPMAX"]
	if stringify:
		return "{0}/{1}".format([_min,_max])
	if is_max:
		return _max

	return _min

func give_hp(value:int):
	primary_stats["HP"] = min(primary_stats["HP"] + value, primary_stats["HPMAX"])

func give_damage(value:int):
	primary_stats["HP"] = max(primary_stats["HP"] - value, 0)

func give_exp(value:int):
	var amount = value
	var _max_exp = primary_stats["EXPMAX"]
	if amount < _max_exp:
		primary_stats["EXP"] += amount
		emit_level_up(0)
	
	while _max_exp <= amount:
		primary_stats["EXP"] += amount
		amount = amount - _max_exp
		emit_level_up(amount)

func emit_level_up(amount):
	if not is_level_up():
		return
	level_up(amount)

func is_level_up():
	return primary_stats["EXP"] >= primary_stats["EXPMAX"]

func level_up(reamin = 0):
	primary_stats["EXP"] = reamin
	primary_stats["LEVEL"] += 1
	primary_stats.update()
	secondary_stats.update()





extends Node
class_name Level

const sum_of_leveling_time = 401700
const minLevel = 1
const maxLevel = 99
const leveling_time = {
	"lt36":60,
	"lt70":5400,
	"lt100":7200
}

var levels={}

func init_level():
	for i in range(minLevel,maxLevel):
		if(i < 36):
			levels[str(i)] = _calc_level_exp(i,leveling_time["lt36"])
		elif((i < 70)):
			levels[str(i)] = _calc_level_exp(i,leveling_time["lt70"])
		elif((i < 100)):
			levels[str(i)] = _calc_level_exp(i,leveling_time["lt100"])
	print(levels)

func _calc_level_exp(level,const_time):
	var r = (level * const_time * 1000000) / maxLevel  / sum_of_leveling_time * maxLevel 
	var mods = r- ( r % 100 )
	if(mods == 0):
		return  100
	return mods

extends Node
class_name Props

const sum_of_leveling_time = 401700
const minLevel = 1
const maxLevel = 99
const leveling_time = {
	"lt36":60,
	"lt70":5400,
	"lt100":7200
}

var props=[] setget ,get_levels_props

func init_level():
	for i in range(minLevel,maxLevel):
		var _o = {}
		if(i < 36):
			_o['expr'] = _calc_level_exp(i,leveling_time["lt36"])
		elif((i < 70)):
			_o['expr'] = _calc_level_exp(i,leveling_time["lt70"])
		elif((i < 100)):
			_o['expr'] = _calc_level_exp(i,leveling_time["lt100"])
		_o['hp'] =_calc_level_hp(i)
		_o['mp'] = _calc_level_mp(i)
		props.append(_o)

func _calc_level_exp(level,const_time):
	var r = (level * const_time * 1000000) / maxLevel  / sum_of_leveling_time * maxLevel 
	var mods = r - ( r % 100 )
	if(mods == 0):
		return  100
	return mods
	
func _calc_level_hp(i):
	return {
		'fs':int (14 + (int(i/ 15 +  2)*i)),
		'ds':int (14 + (int(i/ 6  +  3)*i)),
		'zs':int (14 + (int(i/ 4  +  5)*i))
	}

func _calc_level_mp(i):
		return {
		'fs':int(13 + (int(i/ 5  +  2)*2.2*i)),
		'ds':int(13 + (int(i/ 8  +  5)*2.2*i)),
		'zs':int(13 + (i*3.5))
	}

func get_levels_props():
	return props

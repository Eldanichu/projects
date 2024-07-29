extends BaseProperties
class_name MonsterProperties

var mname:String:
	set(value):
		mname = value
		prop["mname"] = value

### ----------------------------------------------------------------------------

var atk_spd:float:
	set(value):
		atk_spd = value
		prop["atk_spd"] = value

func _init():
	super()

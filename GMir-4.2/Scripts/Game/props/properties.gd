extends BaseProperties
class_name PlayerProperties

### ----------------------------------------------------------------------------
var job:int = 0
# range 1-100
var mf:int:
	set(value):
		mf = value
		prop["mf"] = value

var lck:int:
	set(value):
		lck = value
		prop["lck"] = value

func _init():
	super()
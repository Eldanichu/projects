extends RefCounted
class_name Properties

var prop:Dictionary = {}

var hp:int:
	set(value):
		hp = value
		prop["hp"] = value
var hp_max:int = 1:
	set(value):
		hp_max = value
		prop["hp_max"] = value

var mp:int:
	set(value):
		mp = value
		prop["mp"] = value
var mp_max:int = 1:
	get:
		return mp_max
	set(value):
		mp_max = value
		prop["mp_max"] = value

### ----------------------------------------------------------------------------

var expv:int:
	set(value):
		expv = value
		prop["expv"] = value
var expv_max:int = 100:
	set(value):
		expv_max = value
		prop["expv_max"] = value

var level:int = 1:
	set(value):
		level = value
		prop["level"] = value

### ----------------------------------------------------------------------------

var ac:int:
	set(value):
		ac = value
		prop["ac"] = value
var mac:int:
	set(value):
		mac = value
		prop["mac"] = value

# damage reduction
var dr:int:
	set(value):
		dr = value
		prop["dr"] = value

### ----------------------------------------------------------------------------

# int dc_max = dc + (dc * (dcc / 100 * agi))
# default dc = dc + ( mc * 0.08 )
# 100 + ( mc=20 * 0.08 ) = 101
var dc:int:
	set(value):
		dc = value
		prop["dc"] = value
# range 1-100
var dcc:int:
	set(value):
		dcc = value
		prop["dcc"] = value
		
# attack rate
var ar:int:
	set(value):
		ar = value
		prop["ar"] = value


# magic attack rate
var mar:int:
	set(value):
		mar = value
		prop["mar"] = value
var mc:int:
	set(value):
		mc = value
		prop["mc"] = value
		
# range 1-100
var mcc:int:
	set(value):
		mcc = value
		prop["mcc"] = value
		
# range 1-10
var agi:int:
	set(value):
		agi = value
		prop["agi"] = value
		
# range 1-10
var mod:int:
	set(value):
		mod = value
		prop["mod"] = value

### ----------------------------------------------------------------------------

# range 1-100
var mf:int:
	set(value):
		mf = value
		prop["mf"] = value

var lck:int:
	set(value):
		lck = value
		prop["lck"] = value





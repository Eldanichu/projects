extends RefCounted
class_name Actor

enum CLASS_TYPE {
	WAR,
	WIZ,
	SPT
}

var actor_name:String = "unnamed_actor"

const KEY_EXP:String = "ep"
const KEY_EXP_MAX:String = "ep1"

var prop:Prop = Prop.new()
var class_:BaseClass

func create_class(class_type:CLASS_TYPE):
	match class_type:
		CLASS_TYPE.WAR:
			class_ = WarClass.new()
			class_.prop = prop
			return class_ as WarClass
			

func set_exp(amount: int, clear: bool = true):
	var remain: int = amount - prop[KEY_EXP]
	var _max = prop[KEY_EXP_MAX]
	if amount < _max:
		prop[KEY_EXP] = prop[KEY_EXP] + amount
	elif remain >= _max:
		prop[KEY_EXP] = remain - prop[KEY_EXP_MAX]
		remain = amount - prop[KEY_EXP_MAX]
		level_up()
		while remain >= _max:
			prop[KEY_EXP] = prop[KEY_EXP] + remain
			remain = amount - prop[KEY_EXP_MAX]
			if prop[KEY_EXP] >= prop[KEY_EXP_MAX]:
				level_up()
	if clear:
		prop[KEY_EXP] = 0

func exp_calc() -> int:
	var lv = prop.lv
	return 0

func level_up():
	prop.lv = prop.lv + 1
	prop.ep = 0

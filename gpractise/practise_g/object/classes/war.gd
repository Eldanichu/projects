extends BaseClass
class_name WarClass

func calc():
	super()
	hp()
	mp()

func hp():
	c = 14
	b = 2
	r = 2
	a = 1.1
	var lv:int = prop.lv
	var res = c + (round( lv / b + r * a )) * lv
	prop.hp1 = res
	
func mp():
	c = 13
	b = 12
	r = 2
	a = 1
	var lv:int = prop.lv
	var res = c + (round(( lv / b + r ) * a)) * lv
	prop.mp1 = res

extends BaseClass
class_name WarClass

func calc():
	hp()
	mp()

func hp():
	c = 14
	b = 15
	r = 2
	a = 1.5
	var lv:int = prop.lv
	var res = c + (round( lv / b + r * a )) * lv
	prop.hp1 = res
	
func mp():
	c = 13
	b = 5
	r = 2
	a = 2.2
	var lv:int = prop.lv
	var res = c + (round(( lv / b + r ) * a)) * lv
	prop.mp1 = res

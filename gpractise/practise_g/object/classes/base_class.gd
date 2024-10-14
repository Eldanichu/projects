extends RefCounted
class_name BaseClass

var c:float = 6.0
var b:float = 2.0
var r:float = 1.0
var a:float = 1.0

var prop:Prop

func calc():
	ep()

func ep():
	c = 100
	b = 7
	r = 15
	a = 5
	var lv:int = prop.lv
	var res = c + (round(( lv / b + r ) * a)) * lv
	prop.ep1 = res

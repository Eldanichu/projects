extends RefCounted
class_name P

func _init(title, p0 = "", p1 = "",p2 = "",p3 = "",p4 = "",p5 = "") -> void:
	print(
		"----------------------------------",title," [START]----------------------------------\n"
	)
	var fstr = [p0,p1,p2,p3,p4,p5]
	print(
		p0,"\n",
		show_if(p1),
		show_if(p2),
		show_if(p3),
		show_if(p4),
		show_if(p5),
	)
	print(
		"----------------------------------",title," [END]----------------------------------\n\n"
	)

func show_if(val):
	if val == "" or val == null:
		return ""
	else:
		return "" + "\n"

static func array_ln(val):
	var s = ""
	var i = 0
	if val is Array:
		for ln in val:
			if i < val.size() - 1:
				s = (s + str(ln)) + "\n"
			else:
				s = (s + str(ln))
			i = i + 1
	return s

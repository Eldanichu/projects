extends RefCounted
class_name Damage

var value:float = 0

func _init():
	
	pass

func source(target, dt:DamageType) -> Damage:
	print(dt.get_type())
	return self

func target(target, dt:DamageType) -> Damage:
	
	return self


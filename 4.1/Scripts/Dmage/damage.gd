extends RefCounted
class_name Damage

enum Type {
	FIRE
}

var target:Array[GameObject] = []
var attacker:GameObject = null

func _init():
	pass

func set_source(object:GameObject) -> Damage:
	
	return self

func set_target(object:GameObject) -> Damage:
	
	return self

func set_targets(objects:Array[GameObject]) -> Damage:
	
	return self

func build(dmg_type:Damage.Type):
	if attacker == null:
		return

func _enqueue_target(object):
	target.append(object)

func _dequeue_target():
	target.pop_front()

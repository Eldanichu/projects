extends RefCounted
class_name Damage

var target:Array[GameActor] = []
var attacker:GameActor = null
var _dmg_type:DamageType.E
var rnd = RandomEx.get_instance()
func _init():
	pass

func set_source(object:GameActor) -> Damage:
	attacker = object
	return self

func set_target(object:GameActor) -> Damage:
	_enqueue_target(object)
	return self

func set_dmg_type(dmg_type:DamageType.E) -> Damage:
	_dmg_type = dmg_type
	return self

func buildable() -> bool:
	if attacker == null or target == null:
		return false
	return true

func build():
	if not buildable():
		return
	if attacker.dead():
		return
	var dmg_type = DamageType.new(attacker.stats, _dmg_type)
	var dmg = dmg_type.get_damage()
	print("[Damage]{build} crit->",dmg)
	return dmg

func _enqueue_target(object):
	target.append(object)

func _dequeue_target():
	target.pop_front()

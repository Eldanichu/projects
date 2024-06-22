extends RefCounted
class_name BaseAttack

var rnd = RandomEx.get_instance()
var _source:GameObject

func _init(source:GameObject):
	_source = source

func melee_attack(target:GameObject):
	var chance = _source.properties.ar
	var hit = rnd.chance(chance)
	if hit:
		target.prop_set("hp",1,"-")
		target.update_ui()
	print(hit)

















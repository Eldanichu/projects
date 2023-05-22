extends AttackBase
class_name DefaultAttack

func _init() -> void:
	obj = {
		"id":"DefaultAttack",
		"appr":"00000",
		"type":0,
	}

	cd = 0.2

func get_power() -> int:
	var stats:Dictionary = cast.stats
	var ap = AttackPower.new(stats.dc, stats.dc_max)
	ap.CRIT_ATK_RATE = stats.crit_chance
	ap.CRIT_ATK_DMG_INC = stats.crit_strength
	var power = ap.calc()
	
	return power

func start():
	var value = get_power()
	target.give_damage(value)

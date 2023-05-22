extends AttackBase
class_name DefaultAttack

func _init() -> void:
	obj = {
		"id":"DefaultAttack",
		"appr":"00000",
		"type":0,
	}

	cd = 0.2

func draw(value):
	target.set_stat({
		"hp":target.mon_stat.hp - value
	})
	if target.is_dead():
		target.die()

extends GameActor
class_name MonObject

func _init(mon_id):
	super(MonStat.new())
	var row = dbc.query_mon_by(mon_id)
	set_prop(row)

func use_attack(target:GameActor):
	if not can_attack():
		return
	var damage = Damage.new()
	damage.set_source(self).set_target(target).set_dmg_type(DamageType.E.ATK)
	var d = damage.build()
	target.reduce_hp(d)

func use_magic():
	pass

func can_attack() -> bool:
	if dead():
		return false
	return true

func dead() -> bool:
	if stats.HP <= 0:
		stats.HP = max(stats.HP, 0)
		kill()
		return true
	return false

func set_prop(row):
	var mon_props = stats.get_properties()
	for p in mon_props:
		if p in row:
			stats[p] = row[p]
	stats.HPMAX = stats.HP
	stats.MPMAX = stats.MP
	print("setup mon props")

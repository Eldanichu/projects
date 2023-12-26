extends GameActor
class_name MonObject

signal spawned(mon_inst)
signal stats_change()
signal on_attack(mon_inst)
signal on_dead(mon_inst)

func _init(mon_id):
	super(MonStat.new())
	var row = dbc.query_mon_by(mon_id)
	set_prop(row)

func set_hp_t(value:int):
	super(value)
	stats_change.emit()
	dead()
	
func attack(target:GameActor):
	if not can_attack():
		return
	var damage = Damage.new()
	damage.set_source(self).set_target(target).set_dmg_type(DamageType.E.ATK)
	damage.build()

func spell():
	pass

func can_attack() -> bool:
	if dead():
		return false
	return true

func dead() -> bool:
	if stats.HP <= 0:
		stats.HP = 0
		return true
	return false

func set_prop(row):
	var mon_props = stats.get_properties()
	for p in mon_props:
		if p in row:
			stats[p] = row[p]
	stats.HPMAX = stats.HP
	stats.MPMAX = stats.MP
	stats_change.emit()
	print("setup mon props")

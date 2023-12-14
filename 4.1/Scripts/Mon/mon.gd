extends RefCounted
class_name MonObject

var mon_scene:MonsterScene
var mon_stat:MonStat
var auto_attack:bool = false

func _init(mon_id):
	var row = dbc.query_mon_by(mon_id)
	set_prop(row)

func start():
	auto_attack = true

func pause():
	auto_attack = false

func use_attack() -> Damage:
	if not can_attack():
		return
	var damage = Damage.new()
	damage.attacker = self
	
	return damage

func use_magic():
	pass

func can_attack() -> bool:
	if dead() or not auto_attack:
		return false
	
	return true

func dead() -> bool:
	if mon_stat.HP <= 0:
		mon_stat.HP = max(mon_stat.HP, 0)
		return true
	pause()
	return false

func set_prop(row):
	mon_stat = MonStat.new()
	var mon_props = mon_stat.get_properties()
	for p in mon_props:
		if p in row:
			mon_stat[p] = row[p]
	mon_stat.HPMAX = mon_stat.HP
	mon_stat.MPMAX = mon_stat.MP
	print("setup mon props")

extends RefCounted
class_name DamageType

enum E {
	ATK,
	CRIT,
	DEF_BREAK,
	FIRE,
	WIND,
	WATER,
	ICE,
	MAGIC
}

var rnd := RandomEx.get_instance()
var _stats:BaseStat

var damage = 0

func _init(stats:BaseStat, dmg_type:E):
	_stats = stats

func get_damage():
	if not hits():
		damage = 0
		return damage
	damage += rnd.randomf(_stats["ATK"])
	var crit = get_crit_damage()
	damage += crit
	
	return damage

func get_crit_damage() -> int:
	if not is_crit():
		return 0
	var crit_percent = _stats["CRITICAL_DAMAGE"] / 100.0
	return _stats["ATK"] * crit_percent

func hits() -> bool:
	var agi = _stats["AGI"] / 100.0
	var atk_c = _stats.ATK_CHANCE / 100.0
	var c = (atk_c + agi) * 100
	var hit = rnd.hit(min(G.MAX_HIT_CHANCE, c))
	
	return hit

func is_crit() -> bool:
	var crit_chance = _stats["CRITICAL_CHANCE"]
	var hit = rnd.hit(crit_chance)
	
	return hit

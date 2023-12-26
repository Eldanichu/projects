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
var _attacker_stat:BaseStat
var _target_stat:BaseStat

var damage = 0

func _init(attacker:BaseStat, target:BaseStat, dmg_type:E):
	_attacker_stat = attacker
	_target_stat = target

func get_damage():
	if not hits():
		damage = 0
		return damage
	var tdef =  _target_stat["DEF"]
	if def_breaking_atk():
		tdef = 0
	damage += max(rnd.randomf(_attacker_stat["ATK"]) - tdef, 0)
	var crit = get_crit_damage()
	damage += crit
	
	return damage

func def_breaking_atk():
	var lv_a = _attacker_stat["LEVEL"]
	var lv_b = _target_stat["LEVEL"]
	
	return lv_a >= lv_b

func get_crit_damage() -> int:
	if not is_crit():
		return 0
	var crit_percent = _attacker_stat["CRITICAL_DAMAGE"] / 100.0
	return _attacker_stat["ATK"] * crit_percent

func hits() -> bool:
	var agi = _attacker_stat["AGI"] / 100.0
	var atk_c = _attacker_stat.ATK_CHANCE / 100.0
	var c = (atk_c + agi) * 100
	var hit = rnd.hit(min(G.MAX_HIT_CHANCE, c))
	
	return hit

func is_crit() -> bool:
	var crit_chance = _attacker_stat["CRITICAL_CHANCE"]
	var hit = rnd.hit(crit_chance)
	
	return hit

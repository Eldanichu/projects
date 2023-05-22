extends Resource
class_name AttackPower

const _NO_DAMAGE_CRIT_MOD = 1
const _DEFAULT_CRIT = 110
const _MAX_ATK_RATE = 90
const _MAX_CRIT_ATK_RATE = 80
const _MAX_ATK_DMG_INC = 500
const _MAX_CRIT_ATK_DMG_INC = 300

var r := RandomNumberGenerator.new()
var v_min:int
var v_max:int

var ATK_RATE = 45
var CRIT_ATK_RATE = 10
var ATK_RATE_INC = 0
var ATK_DMG_INC = 0
var CRIT_ATK_RATE_INC = 0
var CRIT_ATK_DMG_INC = 0

var damage:int = 0
var _is_crit:bool = false

func _init(
	_v_min:int,
	_v_max:int
) -> void:
	r.randomize()
	v_min = _v_min
	v_max = _v_max
	_is_crit = false

func cap(value):
	return max(0, value)

func attack() -> bool:
	return is_hit(ATK_RATE + ATK_RATE_INC, _MAX_ATK_RATE)

func crit() -> bool:
	return is_hit(CRIT_ATK_RATE + CRIT_ATK_RATE_INC, _MAX_CRIT_ATK_RATE)

func atk_damage():
	if !attack():
		return
	var _damge_mod = min(max(1, cap(ATK_DMG_INC)), _MAX_ATK_DMG_INC)
	damage = (damage + get_damage()) * max((_damge_mod / 100), 1)

func no_damage_mod():
	if damage != 0:
		return
	damage = round(v_min * _NO_DAMAGE_CRIT_MOD) + damage

func crit_damage():
	if crit():
		print("critical")
		_is_crit = true
		no_damage_mod()
		var _crit_mod = min(_DEFAULT_CRIT + cap(CRIT_ATK_DMG_INC), _MAX_CRIT_ATK_DMG_INC)
		damage = round(damage * max(_crit_mod / 100, 1))

func fix_reversed_damage():
	if v_min > v_max:
		v_min = round((v_min - v_max) + 0.5)

func is_hit(rate_min:float, rate_max:float) -> bool:
	var p = min(rate_min / max(rate_max, 1) * 100, rate_max)
	var n = r.randf() * 100 + 1
	var c = (p / 100.0) * 100
	var hit = n < c
	return hit

func get_damage() -> int:
	fix_reversed_damage()
	var _v = r.randi_range(v_max, v_min)
	return _v

func is_crit_damage():
	return _is_crit

func calc() -> int:
	atk_damage()
	crit_damage()
	return damage
